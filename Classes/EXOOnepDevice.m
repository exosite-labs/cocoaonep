//
//  EXOOnepDevice.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepDevice.h"
#import <AFNetworking.h>

NSString *EXOOnepDeviceErrorDomain = @"EXOOnepDeviceErrorDomain";

static NSString *EXOOnepAPIPath = @"/api:v1/rpc/process";

@interface EXOOnepDevice ()
@property(nonatomic,copy) NSURL *host;
@property(strong) AFHTTPRequestOperationManager *manager;

@end

@implementation EXOOnepDevice

+ (EXOOnepDevice *)device
{
    return [[EXOOnepDevice alloc] initWithAuth:nil Host:nil];
}

+ (EXOOnepDevice *)deviceWithHost:(NSURL *)host
{
    return [[EXOOnepDevice alloc] initWithAuth:nil Host:host];
}

- (instancetype)initWithAuth:(EXOOnepAuthKey *)auth Host:(NSURL *)host
{
    if (self = [super init]) {
        self.auth = auth;
        if (host) {
            self.host = host;
        } else {
            self.host = [NSURL URLWithString:@"https://m2.exosite.com/"];
        }
        
        self.manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:self.host];
        self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
        self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return self;
}

- (id)init
{
    return nil;
}

/* ??? Batching. ?Deferring?
 - Have a method for queueing up calls. fe: addDeferredCall:(EXOOnepRequest*)
 - ?another for removal?
 - Then add a doDeferredCallsComplete:(id)
 ? have doRPCwithRequests grab deferred calls?
 ? Have timer flush out deferred calls?
 Think on it.
 */

- (void)doRPCwithRequests:(NSArray *)calls complete:(EXOOnepRPCComplete)complete
{
    return [self doRPCwithAuth:self.auth requests:calls complete:complete];
}

- (void)doRPCwithAuth:(EXOOnepAuthKey*)auth requests:(NSArray*)calls complete:(EXOOnepRPCComplete)complete;
{
    EXOOnepRPCComplete lcomplete = [complete copy];
    if (auth == nil && self.auth == nil) {
        NSError *err = [NSError errorWithDomain:EXOOnepDeviceErrorDomain code:-2 userInfo:@{NSLocalizedDescriptionKey: @"Missing EXOOnepAuthKey"}];
        if (lcomplete) {
            lcomplete(err);
        }
        return;
    }
    
    if (self.queue) {
        self.manager.operationQueue = self.queue;
    }
    
    // calls should be an array of Requests.
    NSUInteger callID = 0;
    
    NSMutableArray *pcalls = [NSMutableArray array];
    for (EXOOnepRequest* req in calls) {
        // check type.
        NSMutableDictionary *md = [[req plistValue] mutableCopy];
        md[@"id"] = @(callID++); // id matches array index!
        [pcalls addObject:md];
    }
    
    NSDictionary *params = @{@"auth": [self.auth plistValue], @"calls": pcalls};
    
    [self.manager POST:EXOOnepAPIPath parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject){
        if ([responseObject isKindOfClass:[NSArray class]]) {
            // Success! (well, at this level anyways.)
            NSArray *responses = responseObject;
            for (NSDictionary *rsp in responses) {
                NSInteger callIndex = [rsp[@"id"] integerValue];
                if (calls[callIndex]) {
                    // ??? double check id?
                    EXOOnepRequest *rq = calls[callIndex];
                    [rq doResult:rsp error:nil];
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
            NSError *error = [NSError errorWithDomain:EXOOnepDeviceErrorDomain code:ec userInfo:@{NSLocalizedDescriptionKey: desc}];
            NSLog(@"Error for %@:  %@", operation, error);
            if (lcomplete) {
                lcomplete(error);
            }
        } else {
            // another error!
            NSError *error = [NSError errorWithDomain:EXOOnepDeviceErrorDomain code:-1 userInfo:@{NSLocalizedDescriptionKey: @"Unknown response type"}];
            NSLog(@"Error for %@:  %@  got: %@", operation, error, responseObject);
            if (lcomplete) {
                lcomplete(error);
            }
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"Error for %@:  %@ ::: %@", operation, error, params);
        if (lcomplete) {
            lcomplete(error);
        }
    }];
    
}


- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    return ([self.host isEqual:[object host]] && [self.auth isEqual:[object auth]]);
}

- (NSUInteger)hash
{
    return (self.auth.hash ^ self.host.hash);
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p, auth: %@ host: %@ >", NSStringFromClass([self class]), self, self.auth, self.host];
}

@end
