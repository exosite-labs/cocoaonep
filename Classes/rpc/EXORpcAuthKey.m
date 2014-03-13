//
//  EXORpcAuthKey.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcAuthKey.h"

@interface EXORpcAuthKey ()
@property(copy) NSDictionary *auth;
@end

@implementation EXORpcAuthKey

+ (EXORpcAuthKey *)authWithCIK:(NSString *)cik
{
    return [[EXORpcAuthKey alloc] initWithCIK:cik];
}

+ (EXORpcAuthKey *)authWithCIK:(NSString *)cik client:(NSString *)clientid
{
    return [[EXORpcAuthKey alloc] initWithAuth:@{@"cik": [cik copy], @"client_id": [clientid copy]}];
}

+ (EXORpcAuthKey *)authWithCIK:(NSString *)cik resource:(NSString *)rid
{
    return [[EXORpcAuthKey alloc] initWithAuth:@{@"cik": [cik copy], @"resource_id": [rid copy]}];
}

- (instancetype)init
{
    return nil;
}

- (instancetype)initWithCIK:(NSString *)cik
{
    return [self initWithAuth:@{@"cik": [cik copy]}];
}

- (instancetype)initWithAuth:(NSDictionary*)auth
{
    if (self = [super init]) {
        self.auth = auth;
    }
    return self;
}

- (NSDictionary *)plistValue
{
    return [self.auth copy];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p, auth: %@>", NSStringFromClass([self class]), self, self.auth];
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    return [self.auth isEqualToDictionary:[object auth]];
}

- (NSUInteger)hash
{
    return self.auth.hash;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

@end
