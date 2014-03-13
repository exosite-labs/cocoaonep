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
@property(assign) EXORpcDataportFormat_t format;
@property(copy) NSNumber *retentionCount;
@property(copy) NSNumber *retentionDuration;
@property(strong) EXORpcDatarule *rule;
@property(strong) EXORpcResourceID *subscribe;

@end
