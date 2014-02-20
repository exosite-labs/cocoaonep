//
//  EXOOnepCreateDataportRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepCreateDataportRequest.h"

@implementation EXOOnepCreateDataportRequest

- (NSDictionary *)plistValue
{
    NSMutableDictionary *args = [NSMutableDictionary dictionary];
    switch (self.format) {
        case EXOOnepDataportFormatFloat:
            args[@"format"] = @"float";
            break;
        case EXOOnepDataportFormatInteger:
            args[@"format"] = @"integer";
            break;
        case EXOOnepDataportFormatString:
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
    if (self.subscribe) {
        args[@"subscribe"] = [self.subscribe plistValue];
    }
    NSMutableDictionary *reten = [NSMutableDictionary dictionary];
    if (self.retentionCount) {
        reten[@"count"] = self.retentionCount;
    } else {
        reten[@"count"] = @"infinity";
    }
    if (self.retentionDuration) {
        reten[@"duration"] = self.retentionDuration;
    } else {
        reten[@"duration"] = @"infinity";
    }
    args[@"retention"] = reten;
    if (self.preprocess) {
        args[@"preprocess"] = self.preprocess;
    } else {
        args[@"preprocess"] = @[];
    }
    args[@"visibility"] = @"parent"; // Undocumented.
    
    return @{ @"procedure": @"create", @"arguments": @[@"dataport", args]};
}

@end
