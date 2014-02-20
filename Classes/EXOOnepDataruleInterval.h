//
//  EXOOnepDataruleInterval.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepDatarule.h"

@interface EXOOnepDataruleInterval : EXOOnepDatarule <NSCopying>
@property(nonatomic,assign,readonly) EXOOnepDataruleComparison_t comparison;
@property(nonatomic,copy,readonly) NSNumber *constant;
@property(nonatomic,copy,readonly) NSNumber *timeout;
@property(nonatomic,assign,readonly) BOOL repeat;

+ (EXOOnepDataruleInterval*)dataruleIntervalWithComare:(EXOOnepDataruleComparison_t)comparison constant:(NSNumber*)constant timeout:(NSNumber*)timeout repeat:(BOOL)repeat;
- (instancetype)initWithComare:(EXOOnepDataruleComparison_t)comparison constant:(NSNumber*)constant timeout:(NSNumber*)timeout repeat:(BOOL)repeat;
@end
