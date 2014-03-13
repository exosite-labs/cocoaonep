//
//  EXOPortalDomain.m
//
//  Created by Michael Conrad Tadpol Tilstra on 3/13/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOPortalDomain.h"

@interface EXOPortalDomain ()
@property(copy,nonatomic) NSString *role;
@property(copy,nonatomic) NSString *name;
@property(copy,nonatomic) NSString *domain;
@end

@implementation EXOPortalDomain

+ (EXOPortalDomain *)domainWithRole:(NSString *)role name:(NSString *)name domain:(NSString *)domain
{
    return [[EXOPortalDomain alloc] initWithRole:role name:name domain:domain];
}

+ (EXOPortalDomain *)domainWithDictionary:(NSDictionary *)dict
{
    id tname = dict[@"name"];
    id trole = dict[@"role"];
    id tdomain = dict[@"domain"];
    
    if (tname == nil  || trole == nil || tdomain == nil) {
        return nil;
    }
    
    if (![trole isKindOfClass:[NSString class]]) {
        return nil;
    }
    if (![tname isKindOfClass:[NSString class]]) {
        return nil;
    }
    if (![tdomain isKindOfClass:[NSURL class]]) {
        tdomain = [tdomain host];
    }
    if (![tdomain isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    return [[EXOPortalDomain alloc] initWithRole:trole name:tname domain:tdomain];
}

- (instancetype)initWithRole:(NSString *)role name:(NSString *)name domain:(NSString *)domain
{
    if (self = [super init]) {
        self.name = name;
        self.role = role;
        self.domain = domain;
    }
    return self;
}
@end
