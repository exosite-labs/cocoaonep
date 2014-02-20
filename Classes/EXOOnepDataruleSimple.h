//
//  EXOOnepDataruleSimple.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepDatarule.h"

@interface EXOOnepDataruleSimple : EXOOnepDatarule <NSCopying>
@property(nonatomic,assign,readonly) EXOOnepDataruleComparison_t comparison;
@property(nonatomic,copy,readonly) NSNumber *constant;
@property(nonatomic,assign,readonly) BOOL repeat;

+ (EXOOnepDataruleSimple*)dataruleSimpleWithCompare:(EXOOnepDataruleComparison_t)comparison constant:(NSNumber*)constant repeat:(BOOL)repeat;
- (instancetype)initWithCompare:(EXOOnepDataruleComparison_t)comparison constant:(NSNumber*)constant repeat:(BOOL)repeat;
@end
