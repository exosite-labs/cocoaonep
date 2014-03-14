//
//  EXOPortalNewUser.m
//
//  Created by Michael Conrad Tadpol Tilstra on 3/14/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOPortalNewUser.h"


@interface EXOPortalNewUser ()
@property(copy,nonatomic) NSString* email;
@property(copy,nonatomic) NSString* password;
@property(copy,nonatomic) NSString* plan;
@property(copy,nonatomic) NSString* firstName;
@property(copy,nonatomic) NSString* lastName;
@end


@implementation EXOPortalNewUser

+ (EXOPortalNewUser *)userWithEmail:(NSString *)email password:(NSString *)password plan:(NSString *)plan
{
    return [[EXOPortalNewUser alloc] initWithEmail:email password:password plan:plan firstName:nil lastName:nil];
}

+ (EXOPortalNewUser *)userWithEmail:(NSString *)email password:(NSString *)password plan:(NSString *)plan firstName:(NSString *)firstName lastName:(NSString *)lastName
{
    return [[EXOPortalNewUser alloc] initWithEmail:email password:password plan:plan firstName:firstName lastName:lastName];
}

- (id)init
{
    return nil;
}

- (instancetype)initWithEmail:(NSString *)email password:(NSString *)password plan:(NSString *)plan firstName:(NSString *)firstName lastName:(NSString *)lastName
{
    if (self = [super init]) {
        self.email = email;
        self.password = password;
        self.plan = plan;
        self.firstName = firstName;
        self.lastName = lastName;
    }
    return self;
}

- (id)plistValue
{
    NSMutableDictionary *ret = [NSMutableDictionary new];
    ret[@"email"] = self.email;
    ret[@"password"] = self.password;
    ret[@"plan"] = self.plan;
    if (self.firstName) {
        ret[@"first_name"] = self.firstName;
    }
    if (self.lastName) {
        ret[@"last_name"] = self.lastName;
    }
    
    return [ret copy];
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    return ([self.email isEqual:[object email]] &&
            [self.password isEqual:[object password]] &&
            [self.plan isEqual:[object plan]] &&
            [self.firstName isEqual:[object firstName]] &&
            [self.lastName isEqual:[object lastName]]
            );
}

- (NSUInteger)hash
{
    return (self.email.hash ^ self.password.hash ^ self.plan.hash ^ self.firstName.hash ^ self.lastName.hash);
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p, email: %@ password: *** plan: %@ firstName: %@ lastName: %@ >", NSStringFromClass([self class]), self, self.email, self.plan, self.firstName, self.lastName];
}

@end
