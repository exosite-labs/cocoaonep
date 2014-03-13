//
//  EXORpcCreateDataruleRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcDataruleResource.h"

@implementation EXORpcDataruleResource

- (NSArray *)plistValue
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
    
    return @[@"datarule", [args copy]];
}

@end
