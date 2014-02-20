//
//  EXOOnepDataruleTimeout.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepDatarule.h"

@interface EXOOnepDataruleTimeout : EXOOnepDatarule <NSCopying>
@property(nonatomic,copy,readonly) NSNumber *timeout;
@property(nonatomic,assign,readonly) BOOL repeat;

+ (EXOOnepDataruleTimeout*)dataruleTimeoutWithTimeout:(NSNumber*)timeout repeat:(BOOL)repeat;
- (instancetype)initWithTimeout:(NSNumber*)timeout repeat:(BOOL)repeat;
@end
