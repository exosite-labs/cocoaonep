//
//  EXOExositeSimpleDevice.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOExositeSimpleDevice.h"
#import <AFNetworking.h>

static NSString *EXOExositeURL = @"https://m2.exosite.com/onep:v1/stack/alias";

@interface EXOExositeSimpleDevice ()
@property(strong) AFHTTPRequestOperationManager *manager;
@property(nonatomic,copy) NSString *CIK;
@end

@implementation EXOExositeSimpleDevice

- (id)init
{
    return nil;
}

- (id)initWithCIK:(NSString*)CIK
{
    if (self = [super init]) {
        if (CIK == nil) {
            return nil;
        }
        self.CIK = [CIK copy];
        self.manager = [AFHTTPRequestOperationManager manager];
        self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [self.manager.requestSerializer setValue:self.CIK forHTTPHeaderField:@"X-Exosite-CIK"];
    }
    return self;
}


- (void)writeAliases:(NSDictionary*)data complete:(EXOExositeSimpleClientWriteComplete)complete
{
    EXOExositeSimpleClientWriteComplete lcomplete = [complete copy];
    
    [self.manager POST:EXOExositeURL parameters:data success:^(AFHTTPRequestOperation *op, id obj){
        NSLog(@"got a %@ with %@", [obj class], obj);
        if(lcomplete) lcomplete(nil);
    } failure:^(AFHTTPRequestOperation *operation , NSError *error){
        NSLog(@"Got error: %@", error);
        if(lcomplete) lcomplete(error);
    }];
}

- (void)readAliases:(NSArray*)aliases complete:(EXOExositeSimpleClientReadComplete)complete
{
    EXOExositeSimpleClientReadComplete lcomplete = [complete copy];
    NSMutableDictionary *mdict = [NSMutableDictionary dictionaryWithCapacity:aliases.count];
    for (id obj in aliases) {
        [mdict setObject:[NSNull null] forKey:obj];
    }
    
    [self.manager GET:EXOExositeURL parameters:mdict success:^(AFHTTPRequestOperation *op, id obj){
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
