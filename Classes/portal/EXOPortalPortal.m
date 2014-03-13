//
//  EXOPortalPortal.m
//
//  Created by Michael Conrad Tadpol Tilstra on 3/13/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOPortalPortal.h"

@interface EXOPortalPortal ()
@property(copy,nonatomic) NSString *name;
@property(copy,nonatomic) NSString *domain;
@property(copy,nonatomic) NSString *role;
@property(copy,nonatomic) NSString *key;
@property(copy,nonatomic) NSString *rid;
@end

@implementation EXOPortalPortal

+ (EXOPortalPortal *)portalWithName:(NSString *)name domain:(NSString *)domain role:(NSString *)role key:(NSString *)key rid:(NSString *)rid
{
    return [[EXOPortalPortal alloc] initWithName:name domain:domain role:role key:key rid:rid];
}

+ (EXOPortalPortal *)portalWithDictionary:(NSDictionary *)dict
{
    id tname = dict[@"name"];
    id tdomain = dict[@"domain"];
    id trole = dict[@"role"];
    id tkey = dict[@"key"];
    id trid = dict[@"rid"];
    
    if (tname == nil || tdomain == nil || trole == nil) {
        return nil;
    }
    if (tkey == nil && trid == nil) {
        return nil;
    }
    
    if (![tname isKindOfClass:[NSString class]]) {
        return nil;
    }
    if (![trole isKindOfClass:[NSString class]]) {
        return nil;
    }
    if (![tdomain isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    if (tkey && ![tkey isKindOfClass:[NSString class]]) {
        return nil;
    }
    if (trid && ![trid isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    return [[EXOPortalPortal alloc] initWithName:tname domain:tdomain role:trole key:tkey rid:trid];
}

- (id)init
{
    return nil;
}

- (instancetype)initWithName:(NSString *)name domain:(NSString *)domain role:(NSString *)role key:(NSString *)key rid:(NSString *)rid
{
    if (self = [super init]) {
        self.name = name;
        self.domain = domain;
        self.role = role;
        self.key = key;
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
            [self.domain isEqual:[object domain]] &&
            [self.role isEqual:[object role]] &&
            [self.key isEqual:[object key]] &&
            [self.rid isEqual:[object rid]]
            );
}

- (NSUInteger)hash
{
    return (self.name.hash ^ self.domain.hash ^ self.role.hash ^ self.key.hash ^ self.rid.hash);
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p, name: %@ domain: %@ role: %@ key: %@ rid: %@ >", NSStringFromClass([self class]), self, self.name, self.domain, self.role, self.key, self.rid];
}

@end
