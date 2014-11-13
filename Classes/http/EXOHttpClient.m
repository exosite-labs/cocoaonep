//
//  EXOHttpClient.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOHttpClient.h"
#import <AFNetworking.h>

static NSString *EXOHttpClientAPI = @"/onep:v1/stack/alias";

@interface EXOHttpClient ()
@property(strong) AFHTTPRequestOperationManager *manager;
@property(nonatomic,copy) NSString *CIK;
@property(nonatomic,copy) NSURL *host;
@end

@implementation EXOHttpClient

- (id)init
{
    return nil;
}

- (instancetype)initWithCIK:(NSString *)CIK
{
    return [self initWithCIK:CIK host:nil];
}

- (instancetype)initWithCIK:(NSString*)CIK host:(NSURL *)host
{
    if (self = [super init]) {
        if (CIK == nil) {
            return nil;
        }
        self.CIK = [CIK copy];
        if (host) {
            self.host = host;
        } else {
            self.host = [NSURL URLWithString:@"https://m2.exosite.com/"];
        }
        self.manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:self.host];
        self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [self.manager.requestSerializer setValue:self.CIK forHTTPHeaderField:@"X-Exosite-CIK"];
    }
    return self;
}


- (void)writeAliases:(NSDictionary*)data complete:(EXOHttpClientWriteComplete)complete
{
    EXOHttpClientWriteComplete lcomplete = [complete copy];
    
    [self.manager POST:EXOHttpClientAPI parameters:data success:^(AFHTTPRequestOperation *op, id obj){
        //NSLog(@"got a %@ with %@", [obj class], obj);
        if(lcomplete) lcomplete(nil);
    } failure:^(AFHTTPRequestOperation *operation , NSError *error){
        //NSLog(@"Got error: %@", error);
        if(lcomplete) lcomplete(error);
    }];
}

- (void)readAliases:(NSArray*)aliases complete:(EXOHttpClientReadComplete)complete
{
    EXOHttpClientReadComplete lcomplete = [complete copy];
    NSMutableDictionary *mdict = [NSMutableDictionary dictionaryWithCapacity:aliases.count];
    for (id obj in aliases) {
        [mdict setObject:[NSNull null] forKey:obj];
    }
    
    [self.manager GET:EXOHttpClientAPI parameters:mdict success:^(AFHTTPRequestOperation *op, id obj){
        //NSLog(@"got a %@ with %@", [obj class], obj);
        // ??? what class is the result obj?
        if(lcomplete) lcomplete(obj, nil);
    } failure:^(AFHTTPRequestOperation *op, NSError *err) {
        //NSLog(@"Got error: %@", err);
        if(lcomplete) lcomplete(nil, err);
    }];
}


- (void)waitAliases:(NSArray*)aliases complete:(EXOHttpClientReadComplete)complete
{
    [self waitAliases:aliases timeout:nil since:nil complete:complete];
}

- (void)waitAliases:(NSArray*)aliases timeout:(NSNumber*)timeout since:(NSDate*)since complete:(EXOHttpClientReadComplete)complete
{
    EXOHttpClientReadComplete lcomplete = [complete copy];
    NSMutableDictionary *mdict = [NSMutableDictionary dictionaryWithCapacity:aliases.count];
    for (id obj in aliases) {
        [mdict setObject:[NSNull null] forKey:obj];
    }
    if (since == nil) {
        since = [NSDate date];
    }
    if (timeout) {
        NSInteger tt = timeout.integerValue;
        if (tt < 0) {
            tt = 1;
        }
        if (tt > 300000) {
            tt = 300000;
        }
        timeout = @(tt);
    }

    NSURL *URL = [NSURL URLWithString:EXOHttpClientAPI relativeToURL:self.manager.baseURL];
    NSError *err=nil;
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    NSMutableURLRequest *request = [[serializer requestWithMethod:@"GET" URLString:[URL absoluteString] parameters:mdict error:&err] mutableCopy];
    if (timeout) {
        [request addValue:[timeout stringValue] forHTTPHeaderField:@"Request-Timeout"];
    }
    NSString *df = [NSString stringWithFormat:@"%lu", (long)[since timeIntervalSince1970]];
    [request addValue:df forHTTPHeaderField:@"If-Modified-Since"];

    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFHTTPResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
        if(lcomplete) lcomplete(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(lcomplete) lcomplete(nil, err);
    }];
    [self.manager.operationQueue addOperation:op];
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    return [self.CIK isEqualToString:[object CIK]];
}

- (NSUInteger)hash
{
    return self.CIK.hash;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p, CIK: %@>", NSStringFromClass([self class]), self, self.CIK];
}

@end
