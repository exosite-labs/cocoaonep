//
//  EXOPortalDomain.m
//
//  Created by Michael Conrad Tadpol Tilstra on 3/13/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOPortalDomain.h"

@interface EXOPortalDomain ()
@property(copy,nonatomic) NSString *role;
@property(copy,nonatomic) NSString *rid;
@property(copy,nonatomic) NSString *domain;
@property(copy,nonatomic) NSString *name;
@property(copy,nonatomic) NSString *token;
@end

@implementation EXOPortalDomain

+ (EXOPortalDomain *)domainWithRole:(NSString *)role name:(NSString *)name domain:(NSString *)domain token:(NSString*)token
{
    return [[EXOPortalDomain alloc] initWithRole:role name:name domain:domain token:token];
}

+ (EXOPortalDomain *)domainWithDictionary:(NSDictionary *)dict
{
    id tdomain = dict[@"domain"];
    id trid = dict[@"rid"];
    id trole = dict[@"role"];
    id tname = dict[@"name"];
    id ttoken = dict[@"token"];
    
    if (trid == nil  || trole == nil || tdomain == nil) {
        return nil;
    }
    
    if (![trole isKindOfClass:[NSString class]]) {
        return nil;
    }
    if ([tdomain isKindOfClass:[NSURL class]]) {
        tdomain = [tdomain host];
    }
    if (![tdomain isKindOfClass:[NSString class]]) {
        return nil;
    }
    if (ttoken && ![ttoken isKindOfClass:[NSString class]]) {
        return nil;
    }
    if (tname && ![tname isKindOfClass:[NSString class]]) {
        return nil;
    }

    return [[EXOPortalDomain alloc] initWithRole:trole name:tname domain:tdomain token:ttoken rid:trid];
}

- (instancetype)initWithRole:(NSString *)role name:(NSString *)name domain:(NSString *)domain token:(NSString*)token
{
    if (self = [super init]) {
        self.name = name;
        self.role = role;
        self.domain = domain;
        self.token = token;
    }
    return self;
}

- (instancetype)initWithRole:(NSString *)role name:(NSString *)name domain:(NSString *)domain token:(NSString*)token rid:(NSString*)rid
{
    if (self = [self initWithRole:role name:name domain:domain token:token]) {
        self.rid = rid;
    }
    return self;
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    return ([self.name isEqual:[object name]] &&
            [self.role isEqual:[object role]] &&
            [self.domain isEqual:[object domain]] &&
            [self.token isEqual:[object token]]
            );
}

- (NSUInteger)hash
{
    return (self.name.hash ^ self.role.hash ^ self.domain.hash ^ self.token.hash);
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p, name: %@ role: %@ domain: %@ token: %@ >", NSStringFromClass([self class]), self, self.name, self.role, self.domain, self.token];
}

@end
