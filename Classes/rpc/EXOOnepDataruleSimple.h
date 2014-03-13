//
//  EXORpcDataruleSimple.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcDatarule.h"

@interface EXORpcDataruleSimple : EXORpcDatarule <NSCopying>
@property(nonatomic,assign,readonly) EXORpcDataruleComparison_t comparison;
@property(nonatomic,copy,readonly) NSNumber *constant;
@property(nonatomic,assign,readonly) BOOL repeat;

+ (EXORpcDataruleSimple*)dataruleSimpleWithCompare:(EXORpcDataruleComparison_t)comparison constant:(NSNumber*)constant repeat:(BOOL)repeat;
- (instancetype)initWithCompare:(EXORpcDataruleComparison_t)comparison constant:(NSNumber*)constant repeat:(BOOL)repeat;
@end
