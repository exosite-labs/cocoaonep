//
//  EXORpcCreateDataruleRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcResource.h"
#import "EXORpcDataportResource.h"
#import "EXORpcDataruleSimple.h"
#import "EXORpcDataruleTimeout.h"
#import "EXORpcDataruleInterval.h"
#import "EXORpcDataruleDuration.h"
#import "EXORpcDataruleCount.h"
#import "EXORpcDataruleScript.h"

@interface EXORpcDataruleResource : EXORpcResource
@property(assign,nonatomic,readonly) EXORpcDataportFormat_t format;
@property(copy,nonatomic,readonly) NSNumber *retentionCount;
@property(copy,nonatomic,readonly) NSNumber *retentionDuration;
@property(copy,nonatomic,readonly) EXORpcDatarule *rule;
@property(copy,nonatomic,readonly) EXORpcResourceID *subscribe;

+ (EXORpcDataruleResource*)resourceWithName:(NSString *)name meta:(NSString *)meta public:(BOOL)public format:(EXORpcDataportFormat_t)format retentionCount:(NSNumber*)retentionCount retentionDuration:(NSNumber*)retentionDuration rule:(EXORpcDatarule*)rule subscribe:(EXORpcResourceID*)subscribe;

- (instancetype)initWithName:(NSString *)name meta:(NSString *)meta public:(BOOL)public format:(EXORpcDataportFormat_t)format retentionCount:(NSNumber*)retentionCount retentionDuration:(NSNumber*)retentionDuration rule:(EXORpcDatarule*)rule subscribe:(EXORpcResourceID*)subscribe;

@end
