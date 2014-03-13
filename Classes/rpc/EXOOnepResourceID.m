//
//  EXOOnepResourceID.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepResourceID.h"

@interface EXOOnepResourceID ()
@property(strong) NSString *rid;
@property(strong) NSDictionary *alias;
@end

@implementation EXOOnepResourceID

+ (EXOOnepResourceID*)resourceIDAsSelf
{
    return [[EXOOnepResourceID alloc] init];
}

+ (EXOOnepResourceID *)resourceIDByAlias:(NSString *)alias
{
    return [[EXOOnepResourceID alloc] initWithAlias:alias];
}

+ (EXOOnepResourceID *)resourceIDByRID:(NSString *)rid
{
    return [[EXOOnepResourceID alloc] initWithRID:rid];
}

- (instancetype)init
{
    if (self = [super init]) {
        self.alias = @{@"alias": @""};
    }
    return self;
}

- (instancetype)initWithAlias:(NSString *)alias
{
    if (self = [super init]) {
        self.alias = @{@"alias": [alias copy]};
    }
    return self;
}

- (instancetype)initWithRID:(NSString *)rid
{
    if (self = [super init]) {
        self.rid = [rid copy];
    }
    return self;
}

- (id)plistValue
{
    if (self.rid) {
        return self.rid;
    }
    return self.alias;
}

- (NSString *)description
{
    NSString *details;
    if (self.rid) {
        details = [NSString stringWithFormat:@"RID: %@", self.rid];
    } else if (self.alias == nil) {
        details = @"INVALID";
    } else if ([self.alias[@"alias"] isEqualToString:@""]) {
        details = @"Alias Self";
    } else {
        details = [NSString stringWithFormat:@"alias: %@", self.alias[@"alias"]];
    }
    
    return [NSString stringWithFormat:@"<%@: %p, %@>", NSStringFromClass([self class]), self, details];
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    if (self.rid) {
        return [self.rid isEqualToString:[object rid]];
    }
    return [self.alias isEqualToDictionary:[object alias]];
}

- (NSUInteger)hash
{
    if (self.rid) {
        return self.rid.hash;
    }
    if (!self.alias) {
        return 0;
    }
    return [self.alias[@"alias"] hash];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

@end
