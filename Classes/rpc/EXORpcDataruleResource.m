//
//  EXORpcCreateDataruleRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcDataruleResource.h"

@interface EXORpcDataruleResource ()
@property(assign,nonatomic) EXORpcDataportFormat_t format;
@property(copy,nonatomic) EXORpcResourceRetention *retention;
@property(copy,nonatomic) EXORpcDatarule *rule;
@property(copy,nonatomic) EXORpcResourceID *subscribe;
@property(strong,nonatomic) NSArray *preprocess;
@end

@implementation EXORpcDataruleResource

+ (EXORpcDataruleResource *)dataruleWithName:(NSString *)name script:(NSString *)script
{
    EXORpcResourceRetention *reten = [EXORpcResourceRetention retentionWithCount:@(1000) duration:nil];
    EXORpcDataruleScript *rule = [EXORpcDataruleScript dataruleScriptWithScript:script];
    return [[EXORpcDataruleResource alloc] initWithName:name meta:nil public:NO format:EXORpcDataportFormatString retention:reten rule:rule subscribe:nil preprocess:nil];
}

+ (EXORpcDataruleResource *)dataruleWithName:(NSString *)name rule:(EXORpcDatarule *)rule subscribe:(EXORpcResourceID *)subscribe
{
    EXORpcDataportFormat_t format = EXORpcDataportFormatInteger;
    if ([rule isKindOfClass:[EXORpcDataruleScript class]]) {
        format = EXORpcDataportFormatString;
    }
    return [[EXORpcDataruleResource alloc] initWithName:name meta:nil public:NO format:format retention:nil rule:rule subscribe:subscribe preprocess:nil];
}

- (id)init
{
    return nil;
}

- (id)initWithName:(NSString *)name meta:(NSString *)meta public:(BOOL)public format:(EXORpcDataportFormat_t)format retention:(EXORpcResourceRetention *)retention rule:(EXORpcDatarule *)rule subscribe:(EXORpcResourceID *)subscribe preprocess:(NSArray *)preprocess
{
    if (self = [super initWithName:name meta:meta public:public]) {
        _format = format;
        if (retention == nil) {
            _retention = [EXORpcResourceRetention new];
        } else {
            _retention = [retention copy];
        }
        _rule = [rule copy];
        _subscribe = [subscribe copy];
        _preprocess = [preprocess copy];
    }
    return self;
}

- (instancetype)initWithPList:(NSDictionary *)plist
{
    NSString *name = plist[@"name"];
    NSString *meta = plist[@"meta"];
    EXORpcDataportFormat_t format;
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
    EXORpcDatarule *rule;
    if (plist[@"rule"] == nil) {
        return nil;
    }
    NSDictionary *drule = plist[@"rule"];
    if (drule[@"count"]) {
        rule = [[EXORpcDataruleCount alloc] initWithPList:drule[@"count"]];
    } else if (drule[@"duration"]) {
        rule = [[EXORpcDataruleDuration alloc] initWithPList:drule[@"duration"]];
    } else if (drule[@"interval"]) {
        rule = [[EXORpcDataruleInterval alloc] initWithPList:drule[@"interval"]];
    } else if (drule[@"script"]) {
        rule = [EXORpcDataruleScript dataruleScriptWithScript:drule[@"script"]];
    } else if (drule[@"simple"]) {
        rule = [[EXORpcDataruleSimple alloc] initWithPList:drule[@"simple"]];
    } else if (drule[@"timeout"]) {
        rule = [[EXORpcDataruleTimeout alloc] initWithPList:drule[@"timeout"]];
    } else {
        return nil;
    }

    return [self initWithName:name meta:meta public:[plist[@"public"] boolValue] format:format retention:retention rule:rule subscribe:subscribed preprocess:preprocess];
}

- (NSString *)type
{
    return @"datarule";
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
        default:
            args[@"format"] = @"string";
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
    args[@"retention"] = [self.retention plistValue];
    if (self.rule) {
        args[@"rule"] = [self.rule plistValue];
    }
    if (self.subscribe) {
        args[@"subscribe"] = [self.subscribe plistValue];
    }
    if (self.preprocess) {
        NSMutableArray *ppos = [NSMutableArray new];
        for (EXORpcPreprocessOperation* ppo in self.preprocess) {
            [ppos addObject:[ppo plistValue]];
        }
        args[@"preprocess"] = [ppos copy];
    }

    return [args copy];
}

@end
