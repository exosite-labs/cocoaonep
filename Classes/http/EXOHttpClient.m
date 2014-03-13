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
        NSLog(@"got a %@ with %@", [obj class], obj);
        if(lcomplete) lcomplete(nil);
    } failure:^(AFHTTPRequestOperation *operation , NSError *error){
        NSLog(@"Got error: %@", error);
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
        NSLog(@"got a %@ with %@", [obj class], obj);
        // ??? what class is the result obj?
        if(lcomplete) lcomplete(obj, nil);
    } failure:^(AFHTTPRequestOperation *op, NSError *err) {
        NSLog(@"Got error: %@", err);
        if(lcomplete) lcomplete(nil, err);
    }];
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
