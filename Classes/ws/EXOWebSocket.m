//
//  EXOWebSocket.m
//
//  Created by Michael Conrad Tadpol Tilstra on 10/29/15.
//  Copyright (c) 2015 Exosite. All rights reserved.
//

#import "EXOWebSocket.h"
#import "SRWebSocket.h"


NSString *EXOWebSocketErrorDomain = @"EXOWebSocketErrorDomain";

@interface EXOWebSocket () <SRWebSocketDelegate>
@property (copy,nonatomic) NSURL *domain;
@property (strong,nonatomic) SRWebSocket *wbs;
@property (copy,nonatomic) EXORpcAuthKey *auth;
@property (copy,nonatomic) EXOWebSocketComplete onError;

@property (strong,nonatomic) dispatch_queue_t callbackQ; /// Callbacks are executed in this Queue.
@property (strong,nonatomic) dispatch_queue_t workQ; /// This is used as a mutex

@property (assign,nonatomic) NSUInteger idCounter;
@property (strong,nonatomic) NSMutableDictionary<NSNumber*,EXORpcRequest*> *pending;
@property (strong,nonatomic) NSMutableArray<NSData*> *outgoing; /// Sends are queued here.

@end

@implementation EXOWebSocket

- (instancetype)initWithAuth:(EXORpcAuthKey*)auth domain:(NSURL *)domain onError:(nonnull EXOWebSocketComplete)onError {
    if (auth == nil) {
        return nil;
    }
    if ([super init]) {
        _auth = [auth copy];
        if (domain) {
            _domain = [domain copy];
        } else {
            _domain = [NSURL URLWithString:@"wss://m2.exosite.com/ws/"];
        }
        _onError = [onError copy];
        _callbackQ = dispatch_queue_create("com.exosite.cocoaonep.wbs.callbackQ", DISPATCH_QUEUE_SERIAL);
        _workQ = dispatch_queue_create("com.exosite.cocoaonep.wbs.workQ", DISPATCH_QUEUE_SERIAL);
        _outgoing = [NSMutableArray new];
        _pending = [NSMutableDictionary new];
    }
    return self;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"
- (instancetype)init {
    return nil;
}
#pragma clang diagnostic pop

- (instancetype)initWithAuth:(EXORpcAuthKey*)auth onError:(EXOWebSocketComplete)onError {
    return [self initWithAuth:auth domain:nil onError:onError];
}

- (void)doCalls:(NSArray<EXORpcRequest *> *)calls complete:(EXOWebSocketComplete)complete {
    EXOWebSocketComplete lcomplete = [complete copy];

    if (calls.count == 0) {
        // Nothing to do!
        NSError *err = [NSError errorWithDomain:EXOWebSocketErrorDomain code:EXOWebSocketError_NoRequests userInfo:@{NSLocalizedDescriptionKey: @"No Requests"}];
        if (lcomplete) {
            lcomplete(err);
        }
        return;
    }

    dispatch_async(self.workQ, ^{
        // Auto open.
        if (self.wbs == nil || self.wbs.readyState == SR_CLOSED) {
            [self flushPending];

            self.wbs = [[SRWebSocket alloc] initWithURL:self.domain];
            self.wbs.delegate = self;
            [self.wbs open];

            NSDictionary *tosend =@{@"auth":[self.auth plistValue]};
            NSError *error = nil;
            NSData *data = [NSJSONSerialization dataWithJSONObject:tosend options:0 error:&error];
            if (data) {
                [self.outgoing addObject:data];
            } else {
                dispatch_async(self.callbackQ, ^{
                    NSDictionary *ui= @{NSUnderlyingErrorKey:error};
                    NSError *underError = [NSError errorWithDomain:EXOWebSocketErrorDomain code:EXOWebSocketError_UnderlyingError userInfo:ui];
                    if (lcomplete) {
                        lcomplete(underError);
                    } else {
                        self.onError(underError);
                    }
                });
                return;
            }
        }

        // calls should be an array of Requests.
        NSMutableArray *pcalls = [NSMutableArray array];
        for (EXORpcRequest* req in calls) {
            if (![req isKindOfClass:[EXORpcRequest class]]) {
                NSString *reason = [NSString stringWithFormat: @"Object <%p:%@> is not a child of %@", req, [req class], [EXORpcRequest class]];
                @throw [NSException exceptionWithName:@"EXORpcException" reason:reason userInfo:nil];
            }
            NSMutableDictionary *md = [[req plistValue] mutableCopy];
            NSNumber *idx = @(self.idCounter++);
            md[@"id"] = idx;
            [pcalls addObject:md];
            self.pending[idx] = req;
        }

        NSDictionary *params = @{@"calls": pcalls};
        NSError *error = nil;
        NSData *data = [NSJSONSerialization dataWithJSONObject:params options:0 error:&error];
        if (data) {
            [self.outgoing addObject:data];
        } else {
            dispatch_async(self.callbackQ, ^{
                NSDictionary *ui= @{NSUnderlyingErrorKey:error};
                NSError *underError = [NSError errorWithDomain:EXOWebSocketErrorDomain code:EXOWebSocketError_UnderlyingError userInfo:ui];
                if (lcomplete) {
                    lcomplete(underError);
                } else {
                    self.onError(underError);
                }
            });
            return;
        }

        [self sendOutgoing];
        if (lcomplete) {
            lcomplete(nil);
        }
    });
}

- (void)close {
    dispatch_async(self.workQ, ^{
        [self.wbs closeWithCode:-1 reason:@"closing"];
        self.wbs = nil;
        [self flushPending];
    });
}

// Private call; assumes to be in a dispatch_async(self.workQ)
- (void)flushPending {
    NSDictionary *rsp = @{@"error":@{@"code":@(EXOWebSocketError_WebSocketClosed),
                                     @"context": EXOWebSocketErrorDomain,
                                     @"message": @"WebSocket Closing"}};
    [self.outgoing removeAllObjects];
    for (NSNumber *key in self.pending) {
        EXORpcRequest *rq = self.pending[key];
        dispatch_async(self.callbackQ, ^{
            [rq doResult:rsp];
        });
    }
}

- (void)sendOutgoing {
    dispatch_async(self.workQ, ^{
        if (self.wbs && self.wbs.readyState == SR_OPEN) {
            for (NSData *pkt in self.outgoing) {
                dispatch_async(self.workQ, ^{
                    [self.wbs send:[[NSString alloc] initWithData:pkt encoding:NSUTF8StringEncoding]];
                });
            }
            [self.outgoing removeAllObjects];
        }
    });
}

#pragma mark - SRWebSocketDelegate

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    id result;
    NSError *error=nil;
    if ([message isKindOfClass:[NSData class]]) {
        result = [NSJSONSerialization JSONObjectWithData:message options:0 error:&error];
    } else if ([message isKindOfClass:[NSString class]]) {
        NSString *m = message;
        NSData *data = [m dataUsingEncoding:NSUTF8StringEncoding];
        result = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    }
    if (error) {
        dispatch_async(self.callbackQ, ^{
            NSDictionary *ui = @{NSUnderlyingErrorKey:error};
            NSError *underError = [NSError errorWithDomain:EXOWebSocketErrorDomain code:EXOWebSocketError_UnderlyingError userInfo:ui];
            self.onError(underError);
        });
        return;
    }

    if ([result isKindOfClass:[NSArray class]]) {
        // Success! (well, at this level anyways.)
        NSArray *responses = result;
        dispatch_async(self.workQ, ^{
            for (NSDictionary *rsp in responses) {
                NSNumber *idx = @([rsp[@"id"] integerValue]);
                EXORpcRequest *rq = self.pending[idx];
                self.pending[idx] = nil; // TODO: Unless it is a subscribe request; remove it
                if (rq) {
                    dispatch_async(self.callbackQ, ^{
                        [rq doResult:rsp];
                    });
                }
            }
        });
    } else if ([result isKindOfClass:[NSDictionary class]]) {
        NSDictionary *resp = result;

        if (resp[@"error"]) {
            NSDictionary *errInf = resp[@"error"];
            NSInteger ec = [errInf[@"code"] integerValue];
            NSString *desc = [NSString stringWithFormat:@"msg: %@  context: %@", errInf[@"message"], errInf[@"context"]];
            NSError *error = [NSError errorWithDomain:EXOWebSocketErrorDomain code:ec userInfo:@{NSLocalizedDescriptionKey: desc}];
            dispatch_async(self.callbackQ, ^{
                self.onError(error);
            });
        } else if (resp[@"status"]) {
            NSString *status = resp[@"status"];
            if (![status isEqualToString:@"ok"]) {
                NSDictionary *ui = @{NSLocalizedDescriptionKey: @"Status is not OK", @"response": result};
                NSError *error = [NSError errorWithDomain:EXOWebSocketErrorDomain code:EXOWebSocketError_NotOK userInfo:ui];
                dispatch_async(self.callbackQ, ^{
                    self.onError(error);
                });
            } // Else ok, just go.

        } else {
            NSDictionary *ui = @{NSLocalizedDescriptionKey: @"Malformed Response dictionary", @"response": result};
            NSError *error = [NSError errorWithDomain:EXOWebSocketErrorDomain code:EXOWebSocketError_MalformedResponse userInfo:ui];
            dispatch_async(self.callbackQ, ^{
                self.onError(error);
            });
        }
    } else {
        NSDictionary *ui = @{NSLocalizedDescriptionKey: @"Unknown response type", @"response": result};
        NSError *error = [NSError errorWithDomain:EXOWebSocketErrorDomain code:EXOWebSocketError_UnknownResponse userInfo:ui];
        dispatch_async(self.callbackQ, ^{
            self.onError(error);
        });
    }
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    dispatch_async(self.callbackQ, ^{
        self.onError(error);
    });
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    if (code != SRStatusCodeNormal) {
        NSDictionary *ui = @{NSLocalizedDescriptionKey:reason, @"code":@(code),@"wasClean":@(wasClean)};
        NSError *error = [NSError errorWithDomain:EXOWebSocketErrorDomain code:code userInfo:ui];
        dispatch_async(self.callbackQ, ^{
            self.onError(error);
        });
    }
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    [self sendOutgoing];
}

@end
