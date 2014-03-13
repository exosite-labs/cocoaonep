//
//  EXOOnepCreateDataruleRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepResource.h"
#import "EXOOnepDataportResource.h"
#import "EXOOnepDataruleSimple.h"
#import "EXOOnepDataruleTimeout.h"
#import "EXOOnepDataruleInterval.h"
#import "EXOOnepDataruleDuration.h"
#import "EXOOnepDataruleCount.h"
#import "EXOOnepDataruleScript.h"

@interface EXOOnepDataruleResource : EXOOnepResource
@property(assign) EXOOnepDataportFormat_t format;
@property(copy) NSNumber *retentionCount;
@property(copy) NSNumber *retentionDuration;
@property(strong) EXOOnepDatarule *rule;
@property(strong) EXOOnepResourceID *subscribe;

@end
