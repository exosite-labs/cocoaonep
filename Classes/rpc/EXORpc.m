//
//  EXORpc.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014-2015 Exosite. All rights reserved.
//

#import "EXORpc.h"
#import <AFNetworking/AFNetworking.h>
//#import "AFNetworking.h"

NSString *EXORpcDeviceErrorDomain = @"EXORpcDeviceErrorDomain";

static NSString *EXORpcAPIPath = @"/api:v1/rpc/process";

@interface EXORpc ()
@property(nonatomic,copy) NSURL *domain;
@property (strong,nonatomic) AFHTTPSessionManager *session;
@end

@implementation EXORpc

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
    return [self initWithDomain:domain sessionConfiguration:nil];
}

- (instancetype)initWithDomain:(NSURL *)domain sessionConfiguration:(NSURLSessionConfiguration *)sessionConfig {
    if (self = [super init]) {
        if (domain) {
            _domain = [domain copy];
        } else {
            _domain = [NSURL URLWithString:@"https://m2.exosite.com/"];
        }
        if (sessionConfig) {
            _sessionConfig = [sessionConfig copy];
        } else {
            _sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        }
    }
    return self;

}

- (instancetype)init
{
    return [self initWithDomain:nil];
}

- (AFHTTPSessionManager*)sessionWithConfig:(NSURLSessionConfiguration*)sessionConfig {
    if (sessionConfig == nil) {
        sessionConfig = self.sessionConfig;
    }
    AFHTTPSessionManager *lsem = [[AFHTTPSessionManager alloc] initWithBaseURL:self.domain sessionConfiguration:sessionConfig];
    lsem.requestSerializer = [AFJSONRequestSerializer serializer];
    lsem.responseSerializer = [AFJSONResponseSerializer serializer];

    return lsem;
}

- (void)doRPCwithAuth:(EXORpcAuthKey*)auth requests:(NSArray*)calls complete:(EXORpcRPCComplete)complete
{
    EXORpcRPCComplete lcomplete = [complete copy];
    if (auth == nil) {
        NSError *err = [NSError errorWithDomain:EXORpcDeviceErrorDomain code:EXORpcDeviceError_MissingAuthKey userInfo:@{NSLocalizedDescriptionKey: @"Missing EXORpcAuthKey"}];
        if (lcomplete) {
            lcomplete(err);
        }
        return;
    }

    if (calls.count == 0) {
        // Nothing to do!
        NSError *err = [NSError errorWithDomain:EXORpcDeviceErrorDomain code:EXORpcDeviceError_NoRequests userInfo:@{NSLocalizedDescriptionKey: @"No Requests"}];
        if (lcomplete) {
            lcomplete(err);
        }
        return;
    }

    // calls should be an array of Requests.
    NSUInteger callID = 0;
    BOOL haveWaits = NO;

    NSMutableArray *pcalls = [NSMutableArray array];
    for (EXORpcRequest* req in calls) {
        if (![req isKindOfClass:[EXORpcRequest class]]) {
            NSString *reason = [NSString stringWithFormat: @"Object <%p:%@> is not a child of %@", req, [req class], [EXORpcRequest class]];
            @throw [NSException exceptionWithName:@"EXORpcException" reason:reason userInfo:nil];
        }
        if ([req isKindOfClass:[EXORpcWaitRequest class]]) {
            haveWaits = YES;
        }
        NSMutableDictionary *md = [[req plistValue] mutableCopy];
        md[@"id"] = @(callID++); // id matches array index!
        [pcalls addObject:md];
    }

    NSDictionary *params = @{@"auth": [auth plistValue], @"calls": pcalls};

    AFHTTPSessionManager *session = [self sessionWithConfig:nil];
    session.requestSerializer.timeoutInterval = haveWaits?310:60; // If there is a wait request, need a much longer timeout

    [session POST:EXORpcAPIPath parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
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
            NSError *error = [NSError errorWithDomain:EXORpcDeviceErrorDomain code:EXORpcDeviceError_UnknownResponse userInfo:@{NSLocalizedDescriptionKey: @"Unknown response type"}];
            ///NSLog(@"Error for %@:  %@  got: %@  from: %@", operation, error, responseObject, params);
            if (lcomplete) {
                lcomplete(error);
            }
        }


    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        //NSLog(@"Error for %@:  %@ ::: %@", operation, error, params);
        if (lcomplete) {
            lcomplete(error);
        }
    }];
}

- (NSOperation *)operationWithAuth:(EXORpcAuthKey *)auth requests:(NSArray *)calls complete:(EXORpcRPCComplete)complete
{
    EXORpcRPCComplete lcomplete = [complete copy];
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        [self doRPCwithAuth:auth requests:calls complete:lcomplete];
    }];
    return op;
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
