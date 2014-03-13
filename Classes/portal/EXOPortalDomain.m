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
@property(copy,nonatomic) NSString *token;
@end

@implementation EXOPortalDomain

+ (EXOPortalDomain *)domainWithRole:(NSString *)role name:(NSString *)name domain:(NSString *)domain token:(NSString*)token
{
    return [[EXOPortalDomain alloc] initWithRole:role name:name domain:domain token:token];
}

+ (EXOPortalDomain *)domainWithDictionary:(NSDictionary *)dict
{
    id tname = dict[@"name"];
    id trole = dict[@"role"];
    id tdomain = dict[@"domain"];
    id ttoken = dict[@"token"];
    
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
    if (ttoken && ![ttoken isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    return [[EXOPortalDomain alloc] initWithRole:trole name:tname domain:tdomain token:ttoken];
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
@end
