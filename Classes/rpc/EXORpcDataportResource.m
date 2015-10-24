//
//  EXORpcDataportResource.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014-2015 Exosite. All rights reserved.
//

#import "EXORpcDataportResource.h"

@interface EXORpcDataportResource ()
@property(assign,nonatomic) EXORpcDataportFormat format;
@property(strong,nonatomic) NSArray *preprocess;
@property(strong,nonatomic) EXORpcResourceID *subscribe;
@property(copy,nonatomic) EXORpcResourceRetention *retention;
@end

@implementation EXORpcDataportResource

+ (EXORpcDataportResource *)dataportWithName:(NSString *)name meta:(NSString *)meta public:(BOOL)public format:(EXORpcDataportFormat)format preprocess:(NSArray *)preprocess subscribe:(EXORpcResourceID *)subscribe retention:(EXORpcResourceRetention *)retention
{
    return [[EXORpcDataportResource alloc] initWithName:name meta:meta public:public format:format preprocess:preprocess subscribe:subscribe retention:retention];
}

+ (EXORpcDataportResource *)dataportWithName:(NSString *)name format:(EXORpcDataportFormat)format retention:(EXORpcResourceRetention *)retention
{
    return [[EXORpcDataportResource alloc] initWithName:name meta:nil public:NO format:format preprocess:nil subscribe:nil retention:retention];
}

+ (EXORpcDataportResource *)dataportWithName:(NSString *)name format:(EXORpcDataportFormat)format
{
    return [[EXORpcDataportResource alloc] initWithName:name meta:nil public:NO format:format preprocess:nil subscribe:nil retention:nil];
}

- (instancetype)initWithName:(NSString *)name meta:(NSString *)meta public:(BOOL)public format:(EXORpcDataportFormat)format preprocess:(NSArray *)preprocess subscribe:(EXORpcResourceID *)subscribe retention:(EXORpcResourceRetention *)retention
{
    if (self = [super initWithName:name meta:meta public:public]) {
        _format = format;
        _preprocess = [preprocess copy];
        _subscribe = [subscribe copy];
        _retention = [retention copy];
    }
    return self;
}

- (instancetype)initWithName:(NSString *)name format:(EXORpcDataportFormat)format {
    return [self initWithName:name meta:nil public:NO format:format preprocess:nil subscribe:nil retention:nil];
}

- (instancetype)initWithPList:(NSDictionary *)plist
{
    NSString *name = plist[@"name"];
    NSString *meta = plist[@"meta"];
    EXORpcDataportFormat format;
    if ([plist[@"format"] isEqualToString:@"float"]) {
        format = EXORpcDataportFormatFloat;
    } else if ([plist[@"format"] isEqualToString:@"integer"]) {
            format = EXORpcDataportFormatInteger;
    } else if ([plist[@"format"] isEqualToString:@"string"]) {
        format = EXORpcDataportFormatString;
    } else {
        return nil;
    }
    if (plist[@"subscribe"] == nil) {
        return nil;
    }
    id subscribe = plist[@"subscribe"];
    EXORpcResourceID *subscribed=nil;
    if ([subscribe isKindOfClass:[NSString class]]) {
        subscribed = [EXORpcResourceID resourceIDByRID:plist[@"subscribe"]];
    }
    
    EXORpcResourceRetention *retention = [[EXORpcResourceRetention alloc] initWithPList:plist[@"retention"]];
    NSMutableArray *preprocess = [NSMutableArray new];
    for (NSArray *pp in plist[@"preprocess"]) {
        [preprocess addObject:[[EXORpcPreprocessOperation alloc] initWithPList:pp]];
    }

    return [self initWithName:name meta:meta public:[plist[@"public"] boolValue] format:format preprocess:preprocess subscribe:subscribed retention:retention];
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
    if (self.retention) {
        args[@"retention"] = [self.retention plistValue];
    }
    if (self.preprocess) {
        NSMutableArray *ppos = [NSMutableArray new];
        for (EXORpcPreprocessOperation* ppo in self.preprocess) {
            [ppos addObject:[ppo plistValue]];
        }
        args[@"preprocess"] = [ppos copy];
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
