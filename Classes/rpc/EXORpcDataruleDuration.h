//
//  EXORpcDataruleDuration.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcDatarule.h"

/**
 Duration Datarule
 
 When a value is received, it is immediately used in the configured comparison. If the comparison result is true, the rule waits for the specified timeout period before setting its output to true. If instead the comparison result is false, then false becomes the output of the rule immediately, cancelling any existing timeout.
 */
@interface EXORpcDataruleDuration : EXORpcDatarule <NSCopying>

/**
 Compare operation to use on incoming data
 */
@property(nonatomic,assign,readonly) EXORpcDataruleComparison_t comparison;

/**
 Numerical constant used by #comparison
 */
@property(nonatomic,copy,readonly) NSNumber *constant;

/**
 Timeout in seconds
 */
@property(nonatomic,copy,readonly) NSNumber *timeout;

/**

 Specifies whether output from this rule should be written to its data stack if it is the same as the latest value already on the data stack. If set to true, the output of this rule is always written to the rule's data stack. If set to false, a output is only written if it is different from the previous value.
 */
@property(nonatomic,assign,readonly) BOOL repeat;

/**
 Create a duration datarule

 @param comparison Compare operation to use on incoming data
 @param constant Numerical constant used by #comparison
 @param timeout timeout in seconds
 @param repeat Save repeated values
 @return Duration datarule
 */
+ (EXORpcDataruleDuration*)dataruleDurationWithCompare:(EXORpcDataruleComparison_t)comparison constant:(NSNumber*)constant timeout:(NSNumber*)timeout repeat:(BOOL)repeat;

/**
 Initialize a duration datarule

 @param comparison Compare operation to use on incoming data
 @param constant Numerical constant used by #comparison
 @param timeout timeout in seconds
 @param repeat Save repeated values
 @return Duration datarule
 */
- (instancetype)initWithCompare:(EXORpcDataruleComparison_t)comparison constant:(NSNumber*)constant timeout:(NSNumber*)timeout repeat:(BOOL)repeat;
@end
