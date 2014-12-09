//
//  EXORpc.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpc.h"
#import <AFNetworking.h>

NSString *EXORpcDeviceErrorDomain = @"EXORpcDeviceErrorDomain";

static NSString *EXORpcAPIPath = @"/api:v1/rpc/process";

@interface EXORpc ()
@property(nonatomic,copy) NSURL *domain;
@end

@implementation EXORpc {
    NSUInteger _spinCounter;
    dispatch_queue_t _spinCounterQ;
}

+ (EXORpc *)rpc
{
    return [[EXORpc alloc] initWithDomain:nil];
}

+ (EXORpc *)rpcWithDomain:(NSURL *)domain
{
    return [[EXORpc alloc] initWithDomain:domain];
}

- (instancetype)initWithDomain:(NSURL *)domain
{
    if (self = [super init]) {
        if (domain) {
            self.domain = domain;
        } else {
            self.domain = [NSURL URLWithString:@"https://m2.exosite.com/"];
        }
        self.queue = [NSOperationQueue mainQueue];
        _spinCounterQ = dispatch_queue_create("com.exosite.rpc.spincounter", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (id)init
{
    return nil;
}

- (void)doRPCwithAuth:(EXORpcAuthKey*)auth requests:(NSArray*)calls complete:(EXORpcRPCComplete)complete
{
    NSOperation *op = [self operationWithAuth:auth requests:calls complete:complete];
    [self.queue addOperation:op];
}

- (NSOperation *)operationWithAuth:(EXORpcAuthKey *)auth requests:(NSArray *)calls complete:(EXORpcRPCComplete)complete
{
    EXORpcRPCComplete lcomplete = [complete copy];
    if (auth == nil) {
        NSError *err = [NSError errorWithDomain:EXORpcDeviceErrorDomain code:-2 userInfo:@{NSLocalizedDescriptionKey: @"Missing EXORpcAuthKey"}];
        if (lcomplete) {
            lcomplete(err);
        }
        return nil;
    }

    if (calls.count == 0) {
        // Nothing to do!
        NSError *err = [NSError errorWithDomain:EXORpcDeviceErrorDomain code:-3 userInfo:@{NSLocalizedDescriptionKey: @"No Requests"}];
        if (lcomplete) {
            lcomplete(err);
        }
        return nil;
    }

    // calls should be an array of Requests.
    NSUInteger callID = 0;
    
    NSMutableArray *pcalls = [NSMutableArray array];
    for (EXORpcRequest* req in calls) {
        if (![req isKindOfClass:[EXORpcRequest class]]) {
            NSString *reason = [NSString stringWithFormat: @"Object <%p:%@> is not a child of %@", req, [req class], [EXORpcRequest class]];
            @throw [NSException exceptionWithName:@"EXORpcException" reason:reason userInfo:nil];
        }
        NSMutableDictionary *md = [[req plistValue] mutableCopy];
        md[@"id"] = @(callID++); // id matches array index!
        [pcalls addObject:md];
    }
    
    NSDictionary *params = @{@"auth": [auth plistValue], @"calls": pcalls};

    NSURL *URL = [NSURL URLWithString:EXORpcAPIPath relativeToURL:self.domain];

    NSError *err=nil;
    AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
    NSURLRequest *request = [serializer requestWithMethod:@"POST" URLString:[URL absoluteString] parameters:params error:&err];

    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
        if ([responseObject isKindOfClass:[NSArray class]]) {
            // Success! (well, at this level anyways.)
            NSArray *responses = responseObject;
            for (NSDictionary *rsp in responses) {
                NSInteger callIndex = [rsp[@"id"] integerValue];
                if (calls[callIndex]) {
                    // ??? double check id?
                    EXORpcRequest *rq = calls[callIndex];
                    [rq doResult:rsp];
                }
            }
            if (lcomplete) {
                lcomplete(nil);
            }
        } else if ([responseObject isKindOfClass:[NSDictionary class]]) {
            // An error, one way or the other.
            NSDictionary *errRsp = responseObject;
            NSDictionary *errInf = errRsp[@"error"];
            NSInteger ec = [errInf[@"code"] integerValue];
            NSString *desc = [NSString stringWithFormat:@"msg: %@  context: %@", errInf[@"message"], errInf[@"context"]];
            NSError *error = [NSError errorWithDomain:EXORpcDeviceErrorDomain code:ec userInfo:@{NSLocalizedDescriptionKey: desc}];
            //NSLog(@"Error for %@:  %@", operation, error);
            if (lcomplete) {
                lcomplete(error);
            }
        } else {
            // another error!
            NSError *error = [NSError errorWithDomain:EXORpcDeviceErrorDomain code:-1 userInfo:@{NSLocalizedDescriptionKey: @"Unknown response type"}];
            ///NSLog(@"Error for %@:  %@  got: %@  from: %@", operation, error, responseObject, params);
            if (lcomplete) {
                lcomplete(error);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        //NSLog(@"Error for %@:  %@ ::: %@", operation, error, params);
        if (lcomplete) {
            lcomplete(error);
        }
    }];

    // Now watch the isExecuting to know when to spin
    [op addObserver:self forKeyPath:NSStringFromSelector(@selector(isExecuting)) options:0 context:NULL];
    // And isFinished to know when to stop watching.
    [op addObserver:self forKeyPath:NSStringFromSelector(@selector(isFinished)) options:0 context:NULL];

    return op;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(isExecuting))]) {
        BOOL isExec = [object isExecuting];
        dispatch_async(_spinCounterQ, ^{
            if (isExec) {
                _spinCounter++;
                if (_spinCounter == 1) {
                    if (self.activityChange) {
                        self.activityChange(YES);
                    }
                }
            } else {
                _spinCounter--;
                if (_spinCounter == 0) {
                    if (self.activityChange) {
                        self.activityChange(NO);
                    }
                }
            }
        });

    } else if ([keyPath isEqualToString:NSStringFromSelector(@selector(isFinished))]) {
        if ([object isFinished]) {
            [object removeObserver:self forKeyPath:keyPath];
        }
    }
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    return ([self.domain isEqual:[object domain]]);
}

- (NSUInteger)hash
{
    return (self.domain.hash);
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p, domain: %@ >", NSStringFromClass([self class]), self, self.domain];
}

@end
