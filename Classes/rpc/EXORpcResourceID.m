//
//  EXORpcResourceID.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcResourceID.h"

@interface EXORpcResourceID ()
@property(copy,nonatomic) NSString *rid;
@property(copy,nonatomic) NSString *alias;
@end

@implementation EXORpcResourceID

+ (BOOL)supportsSecureCoding
{
    return YES;
}

+ (EXORpcResourceID*)resourceIDAsSelf
{
    return [[EXORpcResourceID alloc] init];
}

+ (EXORpcResourceID *)resourceIDByAlias:(NSString *)alias
{
    return [[EXORpcResourceID alloc] initWithAlias:alias];
}

+ (EXORpcResourceID *)resourceIDByRID:(NSString *)rid
{
    return [[EXORpcResourceID alloc] initWithRID:rid];
}

+ (EXORpcResourceID*)invalid
{
    return [[EXORpcResourceID alloc] initWithAlias:nil];
}

- (instancetype)init
{
    if (self = [super init]) {
        _alias = @"";
    }
    return self;
}

- (instancetype)initWithAlias:(NSString *)alias
{
    if (self = [super init]) {
        _alias = [alias copy];
    }
    return self;
}

- (instancetype)initWithRID:(NSString *)rid
{
    if (self = [super init]) {
        _rid = [rid copy];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _rid = [aDecoder decodeObjectOfClass:[self class] forKey:NSStringFromSelector(@selector(rid))];
        _alias = [aDecoder decodeObjectOfClass:[self class] forKey:NSStringFromSelector(@selector(alias))];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_rid forKey:NSStringFromSelector(@selector(rid))];
    [aCoder encodeObject:_alias forKey:NSStringFromSelector(@selector(alias))];
}

- (id)plistValue
{
    if (self.rid) {
        return self.rid;
    }
    if (self.alias == nil) {
        return [NSNull null];
    }
    return @{@"alias": self.alias};
}

- (NSString *)description
{
    NSString *details;
    if (_rid) {
        details = [NSString stringWithFormat:@"RID: %@", self.rid];
    } else if (_alias == nil) {
        details = @"INVALID";
    } else if ([_alias isEqualToString:@""]) {
        details = @"Alias Self";
    } else {
        details = [NSString stringWithFormat:@"alias: %@", _alias];
    }
    
    return [NSString stringWithFormat:@"<%@: %p, %@>", NSStringFromClass([self class]), self, details];
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    if (_rid) {
        return [_rid isEqualToString:[object rid]];
    }
    return [_alias isEqualToString:[object alias]];
}

- (NSUInteger)hash
{
    if (_rid) {
        return _rid.hash;
    }
    return _alias.hash;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

@end
