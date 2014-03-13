//
//  EXOPortalAuth.m
//
//  Created by Michael Conrad Tadpol Tilstra on 3/13/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//
//

#import "EXOPortalAuth.h"

@interface EXOPortalAuth ()
@property(copy,nonatomic) NSString *username;
@property(copy,nonatomic) NSString *password;
@end

@implementation EXOPortalAuth

+ (EXOPortalAuth *)authWithUsername:(NSString *)username password:(NSString *)password
{
    return [[EXOPortalAuth alloc] initWithUsername:username password:password];
}

- (id)init
{
    return nil;
}

- (instancetype)initWithUsername:(NSString *)username password:(NSString *)password
{
    if (self = [super init]) {
        self.username = username;
        self.password = password;
    }
    return self;
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    return ([self.username isEqual:[object username]] && [self.password isEqual:[object password]]);
}

- (NSUInteger)hash
{
    return (self.username.hash ^ self.password.hash);
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p, username: %@ password: *** >", NSStringFromClass([self class]), self, self.username];
}

@end
