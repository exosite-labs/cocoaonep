//
//  EXOWebSocket.m
//  Pods
//
//  Created by Michael Conrad Tadpol Tilstra on 10/29/15.
//
//

#import "EXOWebSocket.h"
#import "SRWebSocket.h"

NSString *EXOWebSocketErrorDomain = @"EXOWebSocketErrorDomain";

typedef NS_ENUM(NSUInteger, EXOWebSocketIState) {
    EXOWebSocketIState_NoWebSocket,
    EXOWebSocketIState_SettingUp,
    EXOWebSocketIState_Open,
    EXOWebSocketIState_Closing,
};

@interface EXOWebSocket () <SRWebSocketDelegate>
@property (copy,nonatomic) NSURL *domain;
@property (strong,nonatomic) SRWebSocket *wbs;
@property (copy,nonatomic) EXORpcAuthKey *auth;

@property (assign,nonatomic) EXOWebSocketIState state;

@property (strong,nonatomic) dispatch_queue_t callbackQ; /// Callbacks are executed in this Queue.
@property (strong,nonatomic) dispatch_queue_t workQ; /// This is used as a mutex
@property (assign,nonatomic) NSUInteger idCounter;
@property (strong,nonatomic) NSMutableDictionary *pending;
@property (strong,nonatomic) NSMutableArray<NSData*> *outgoing; /// Sends are queued here.
@end

@implementation EXOWebSocket

- (instancetype)initWithAuth:(EXORpcAuthKey*)auth domain:(NSURL *)domain {
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
        _callbackQ = dispatch_queue_create("com.exosite.cocoaonep.wbs.callbackQ", DISPATCH_QUEUE_SERIAL);
        _workQ = dispatch_queue_create("com.exosite.cocoaonep.wbs.workQ", DISPATCH_QUEUE_SERIAL);
        _outgoing = [NSMutableArray new];
    }
    return self;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"
- (instancetype)init {
    return nil;
}
#pragma clang diagnostic pop

- (instancetype)initWithAuth:(EXORpcAuthKey*)auth {
    return [self initWithAuth:auth domain:nil];
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
            // FIXME: deal with error.

            // FIXME: Need to wait until open.
            [self.wbs send:data];
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
        // FIXME: deal with error.
        [self.wbs send:data];
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
    for (NSNumber *key in self.pending) {
        EXORpcRequest *rq = self.pending[key];
        dispatch_async(self.callbackQ, ^{
            [rq doResult:rsp];
        });
    }
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
    // FIXME: something with the error.

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
    }

    // TODO: checkoutgoing
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    // TODO: something
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    // TODO: something
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket {

}

@end
