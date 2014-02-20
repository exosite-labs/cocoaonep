//
//  EXOOnepDataruleCount.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepDatarule.h"

@interface EXOOnepDataruleCount : EXOOnepDatarule <NSCopying>
@property(nonatomic,assign,readonly) EXOOnepDataruleComparison_t comparison;
@property(nonatomic,copy,readonly) NSNumber *constant;
@property(nonatomic,copy,readonly) NSNumber *count;
@property(nonatomic,copy,readonly) NSNumber *timeout;
@property(nonatomic,assign,readonly) BOOL repeat;

+ (EXOOnepDataruleCount*)dataruleCountWithCompare:(EXOOnepDataruleComparison_t)comparison constant:(NSNumber*)constant count:(NSNumber*)count timeout:(NSNumber*)timeout repeat:(BOOL)repeat;
- (instancetype)initWithCompare:(EXOOnepDataruleComparison_t)comparison constant:(NSNumber*)constant count:(NSNumber*)count timeout:(NSNumber*)timeout repeat:(BOOL)repeat;
@end
