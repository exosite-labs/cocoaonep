//
//  EXORpcCreateDataruleRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcDataruleResource.h"

@interface EXORpcDataruleResource ()
@property(assign,nonatomic) EXORpcDataportFormat_t format;
@property(copy,nonatomic) NSNumber *retentionCount;
@property(copy,nonatomic) NSNumber *retentionDuration;
@property(copy,nonatomic) EXORpcDatarule *rule;
@property(copy,nonatomic) EXORpcResourceID *subscribe;
@end

@implementation EXORpcDataruleResource

+ (EXORpcDataruleResource *)resourceWithName:(NSString *)name meta:(NSString *)meta public:(BOOL)public format:(EXORpcDataportFormat_t)format retentionCount:(NSNumber *)retentionCount retentionDuration:(NSNumber *)retentionDuration rule:(EXORpcDatarule *)rule subscribe:(EXORpcResourceID *)subscribe
{
    return [[EXORpcDataruleResource alloc] initWithName:name meta:meta public:public format:format retentionCount:retentionCount retentionDuration:retentionDuration rule:rule subscribe:subscribe];
}

- (id)init
{
    return nil;
}

- (id)initWithName:(NSString *)name meta:(NSString *)meta public:(BOOL)public format:(EXORpcDataportFormat_t)format retentionCount:(NSNumber *)retentionCount retentionDuration:(NSNumber *)retentionDuration rule:(EXORpcDatarule *)rule subscribe:(EXORpcResourceID *)subscribe
{
    if (self = [super initWithName:name meta:meta public:public]) {
        self.format = format;
        self.retentionCount = retentionCount;
        self.retentionDuration = retentionDuration;
        self.rule = rule;
        self.subscribe = subscribe;
    }
    return self;
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
        args[@"public"] = @"true";
    }
    if (self.retentionCount || self.retentionDuration) {
        NSMutableDictionary *reten = [NSMutableDictionary dictionary];
        if (self.retentionCount) {
            reten[@"count"] = self.retentionCount;
        }
        if (self.retentionDuration) {
            reten[@"duration"] = self.retentionDuration;
        }
        args[@"retention"] = [reten copy];
    }
    if (self.rule) {
        args[@"rule"] = [self.rule plistValue];
    }
    if (self.subscribe) {
        args[@"subscribe"] = [self.subscribe plistValue];
    }
    
    return [args copy];
}

@end
