//
//  EXORpcDataruleTimeout.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcDatarule.h"

@interface EXORpcDataruleTimeout : EXORpcDatarule <NSCopying>
@property(nonatomic,copy,readonly) NSNumber *timeout;
@property(nonatomic,assign,readonly) BOOL repeat;

+ (EXORpcDataruleTimeout*)dataruleTimeoutWithTimeout:(NSNumber*)timeout repeat:(BOOL)repeat;
- (instancetype)initWithTimeout:(NSNumber*)timeout repeat:(BOOL)repeat;
@end
