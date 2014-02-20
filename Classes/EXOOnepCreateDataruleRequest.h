//
//  EXOOnepCreateDataruleRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepCreateRequest.h"
#import "EXOOnepCreateDataportRequest.h"
#import "EXOOnepDataruleSimple.h"
#import "EXOOnepDataruleTimeout.h"
#import "EXOOnepDataruleInterval.h"
#import "EXOOnepDataruleDuration.h"
#import "EXOOnepDataruleCount.h"
#import "EXOOnepDataruleScript.h"

@interface EXOOnepCreateDataruleRequest : EXOOnepCreateRequest
@property(assign) EXOOnepDataportFormat_t format;
@property(copy) NSNumber *retentionCount;
@property(copy) NSNumber *retentionDuration;
@property(strong) EXOOnepDatarule *rule;
@property(strong) EXOOnepResourceID *subscribe;

@end
