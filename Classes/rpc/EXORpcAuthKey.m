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

+ (BOOL)supportsSecureCoding
{
    return YES;
}

+ (BOOL)isCIK:(NSString*)cik
{
    if (cik.length != 40) {
        return NO;
    }
    NSCharacterSet *notAllowed = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFabcdef"] invertedSet];
    NSRange found = [cik rangeOfCharacterFromSet:notAllowed];
    return found.location == NSNotFound;
}

+ (EXORpcAuthKey *)authWithCIK:(NSString *)cik
{
    return [[EXORpcAuthKey alloc] initWithCIK:cik];
}

+ (EXORpcAuthKey *)authWithCIK:(NSString *)cik client:(NSString *)clientid
{
    if (cik == nil || clientid == nil) {
        return nil;
    }
    if (![EXORpcAuthKey isCIK:cik] || ![EXORpcAuthKey isCIK:clientid]) {
        return nil;
    }
    return [[EXORpcAuthKey alloc] initWithAuth:@{@"cik": [cik copy], @"client_id": [clientid copy]}];
}

+ (EXORpcAuthKey *)authWithCIK:(NSString *)cik resource:(NSString *)rid
{
    if (cik == nil || rid == nil) {
        return nil;
    }
    if (![EXORpcAuthKey isCIK:cik] || ![EXORpcAuthKey isCIK:rid]) {
        return nil;
    }
    return [[EXORpcAuthKey alloc] initWithAuth:@{@"cik": [cik copy], @"resource_id": [rid copy]}];
}

- (instancetype)init
{
    return nil;
}

- (instancetype)initWithCIK:(NSString *)cik
{
    if (cik == nil || ![EXORpcAuthKey isCIK:cik]) {
        return nil;
    }
    return [self initWithAuth:@{@"cik": [cik copy]}];
}

- (instancetype)initWithAuth:(NSDictionary*)auth
{
    if (auth == nil) {
        return nil;
    }
    if (self = [super init]) {
        self.auth = auth;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _auth = [aDecoder decodeObjectOfClass:[self class] forKey:NSStringFromSelector(@selector(auth))];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_auth forKey:NSStringFromSelector(@selector(auth))];
}

- (NSDictionary *)plistValue
{
    return [self.auth copy];
}

- (NSString *)cik
{
    return self.auth[@"cik"];
}

- (NSString *)clientid
{
    return self.auth[@"client_id"];
}

- (NSString *)rid
{
    return self.auth[@"resource_id"];
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
