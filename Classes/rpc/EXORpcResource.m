//
//  EXORpcResource.m
//  CocoaOneP
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcResource.h"

@interface EXORpcResource ()
@property(copy,nonatomic) NSString *meta;
@property(copy,nonatomic) NSString *name;
@property(assign,nonatomic) BOOL public;
@end

@implementation EXORpcResource

+ (EXORpcResource *)resourceWithName:(NSString *)name meta:(NSString *)meta public:(BOOL)public
{
    return [[EXORpcResource alloc] initWithName:name meta:meta public:public];
}

+ (EXORpcResource *)resourceWithName:(NSString *)name meta:(NSString *)meta
{
    return [[EXORpcResource alloc] initWithName:name meta:meta];
}

- (id)init
{
    return nil;
}

- (instancetype)initWithName:(NSString *)name meta:(NSString *)meta public:(BOOL)public
{
    if (self = [super init]) {
        self.name = name;
        self.meta = meta;
        self.public = public;
    }
    return self;
}

- (instancetype)initWithName:(NSString *)name meta:(NSString *)meta
{
    return [self initWithName:name meta:meta public:NO];
}

- (NSString *)type
{
    NSException *ex = [NSException exceptionWithName:@"EXORpcResourceException" reason:@"Trying to use class without subclassing first." userInfo:nil];
    @throw ex;
    return nil;
}

- (NSArray *)plistValue
{
    return @[];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p, Type: %@, Name: %@, Meta: %@>", NSStringFromClass([self class]), self, self.type, self.name, self.meta];
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    EXORpcResource *obj = object;
    return [self.name isEqualToString:obj.name] && [self.meta isEqualToString:obj.meta] && self.public == obj.public;
}

- (NSUInteger)hash
{
    return self.name.hash ^ self.meta.hash ^ self.public;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

@end
