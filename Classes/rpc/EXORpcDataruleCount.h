//
//  EXORpcDataruleCount.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcDatarule.h"

@interface EXORpcDataruleCount : EXORpcDatarule <NSCopying>
@property(nonatomic,assign,readonly) EXORpcDataruleComparison_t comparison;
@property(nonatomic,copy,readonly) NSNumber *constant;
@property(nonatomic,copy,readonly) NSNumber *count;
@property(nonatomic,copy,readonly) NSNumber *timeout;
@property(nonatomic,assign,readonly) BOOL repeat;

+ (EXORpcDataruleCount*)dataruleCountWithCompare:(EXORpcDataruleComparison_t)comparison constant:(NSNumber*)constant count:(NSNumber*)count timeout:(NSNumber*)timeout repeat:(BOOL)repeat;
- (instancetype)initWithCompare:(EXORpcDataruleComparison_t)comparison constant:(NSNumber*)constant count:(NSNumber*)count timeout:(NSNumber*)timeout repeat:(BOOL)repeat;
@end
