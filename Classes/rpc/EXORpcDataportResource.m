//
//  EXORpcCreateDataportRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcDataportResource.h"

@implementation EXORpcDataportResource

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
    args[@"retention"] = [reten copy];
    if (self.preprocess) {
        args[@"preprocess"] = self.preprocess;
    } else {
        args[@"preprocess"] = @[];
    }
    args[@"visibility"] = @"parent"; // Undocumented.
    
    return [args copy];
}

@end
