//
//  EXORpcDataruleDuration.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcDatarule.h"

@interface EXORpcDataruleDuration : EXORpcDatarule <NSCopying>
@property(nonatomic,assign,readonly) EXORpcDataruleComparison_t comparison;
@property(nonatomic,copy,readonly) NSNumber *constant;
@property(nonatomic,copy,readonly) NSNumber *timeout;
@property(nonatomic,assign,readonly) BOOL repeat;

+ (EXORpcDataruleDuration*)dataruleDurationWithCompare:(EXORpcDataruleComparison_t)comparison constant:(NSNumber*)constant timeout:(NSNumber*)timeout repeat:(BOOL)repeat;
- (instancetype)initWithCompare:(EXORpcDataruleComparison_t)comparison constant:(NSNumber*)constant timeout:(NSNumber*)timeout repeat:(BOOL)repeat;
@end
