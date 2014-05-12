//
//  EXORpcDataportResource.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcDataportResource.h"

@interface EXORpcDataportResource ()
@property(assign,nonatomic) EXORpcDataportFormat_t format;
@property(strong,nonatomic) NSArray *preprocess;
@property(strong,nonatomic) EXORpcResourceID *subscribe;
@property(copy,nonatomic) EXORpcResourceRetention *retention;
@end

@implementation EXORpcDataportResource

+ (EXORpcDataportResource *)dataportWithName:(NSString *)name meta:(NSString *)meta format:(EXORpcDataportFormat_t)format preprocess:(NSArray *)preprocess subscribe:(EXORpcResourceID *)subscribe retention:(EXORpcResourceRetention *)retention
{
    return [[EXORpcDataportResource alloc] initWithName:name meta:meta format:format preprocess:preprocess subscribe:subscribe retention:retention];
}

+ (EXORpcDataportResource *)dataportWithName:(NSString *)name format:(EXORpcDataportFormat_t)format retention:(EXORpcResourceRetention *)retention
{
    return [[EXORpcDataportResource alloc] initWithName:name meta:nil format:format preprocess:nil subscribe:nil retention:retention];
}

+ (EXORpcDataportResource *)dataportWithName:(NSString *)name format:(EXORpcDataportFormat_t)format
{
    return [[EXORpcDataportResource alloc] initWithName:name meta:nil format:format preprocess:nil subscribe:nil retention:nil];
}

- (instancetype)initWithName:(NSString *)name meta:(NSString *)meta format:(EXORpcDataportFormat_t)format preprocess:(NSArray *)preprocess subscribe:(EXORpcResourceID *)subscribe retention:(EXORpcResourceRetention *)retention
{
    if (self = [super initWithName:name meta:meta]) {
        self.format = format;
        self.preprocess = preprocess;
        self.subscribe = subscribe;
        if (retention == nil) {
            self.retention = [EXORpcResourceRetention new];
        } else {
            self.retention = retention;
        }
    }
    return self;
}

- (id)init
{
    return nil;
}

- (NSString *)type
{
    return @"dataport";
}

- (id)plistValue
{
    NSMutableDictionary *args = [NSMutableDictionary dictionary];
    switch (self.format) {
        case EXORpcDataportFormatFloat:
            args[@"format"] = @"float";
            break;
        case EXORpcDataportFormatInteger:
            args[@"format"] = @"integer";
            break;
        case EXORpcDataportFormatString:
            args[@"format"] = @"string";
            break;
        case EXORpcDataportFormatUnchanged:
        default:
            break;
    }
    if (self.meta) {
        args[@"meta"] = self.meta;
    }
    if (self.name) {
        args[@"name"] = self.name;
    }
    if (self.public) {
        args[@"public"] = @YES;
    }
    if (self.subscribe) {
        args[@"subscribe"] = [self.subscribe plistValue];
    }
    args[@"retention"] = [self.retention plistValue];
    if (self.preprocess) {
        args[@"preprocess"] = self.preprocess;
    } else {
        args[@"preprocess"] = @[];
    }
    args[@"visibility"] = @"parent"; // Undocumented.
    
    return [args copy];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p, Type: %@, %@>", NSStringFromClass([self class]), self, self.type, [self plistValue]];
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    EXORpcDataportResource *obj = object;
    return  [self.name isEqualToString:obj.name] &&
            [self.meta isEqualToString:obj.meta] &&
            self.public == obj.public &&
            self.format == obj.format &&
            [self.preprocess isEqual:obj.preprocess] &&
            [self.subscribe isEqual:obj.subscribe] &&
            [self.retention isEqual:obj.retention];
}

- (NSUInteger)hash
{
    return self.name.hash ^ self.meta.hash ^ self.public ^ self.format ^ self.preprocess.hash ^ self.subscribe.hash ^ self.retention.hash;
}

@end
