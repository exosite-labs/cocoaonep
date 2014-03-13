//
//  EXOOnepAuthKey.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepAuthKey.h"

@interface EXOOnepAuthKey ()
@property(copy) NSDictionary *auth;
@end

@implementation EXOOnepAuthKey

+ (EXOOnepAuthKey *)authWithCIK:(NSString *)cik
{
    return [[EXOOnepAuthKey alloc] initWithCIK:cik];
}

+ (EXOOnepAuthKey *)authWithCIK:(NSString *)cik client:(NSString *)clientid
{
    return [[EXOOnepAuthKey alloc] initWithAuth:@{@"cik": [cik copy], @"client_id": [clientid copy]}];
}

+ (EXOOnepAuthKey *)authWithCIK:(NSString *)cik resource:(NSString *)rid
{
    return [[EXOOnepAuthKey alloc] initWithAuth:@{@"cik": [cik copy], @"resource_id": [rid copy]}];
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
