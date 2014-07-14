//
//  EXORpcDataruleInterval.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcDatarule.h"

/**
 Interval Datarule

 This rule outputs the result of the comparison any time an input value is received. Additionally, if the comparison result is true, a timer is started. If the timer elapses, the rule output becomes true, and the timer is restarted. If a input value is received that makes the comparison false, false is output and the timer is canceled.
 */
@interface EXORpcDataruleInterval : EXORpcDatarule <NSCopying>

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
 Specifies whether new inputs that would not change the output should be written to the output data stack anyway. If set to true, the output of this rule is always written to the rule's data stack. If set to false, a output is only written if it's different from the previous value.
 */
@property(nonatomic,assign,readonly) BOOL repeat;

/**
 Create an interval datarule

 @param comparison Compare operation to use on incoming data
 @param constant Numerical constant used by #comparison
 @param timeout timeout in seconds
 @param repeat Save repeated values
 @return Interval datarule
 */
+ (EXORpcDataruleInterval*)dataruleIntervalWithComare:(EXORpcDataruleComparison_t)comparison constant:(NSNumber*)constant timeout:(NSNumber*)timeout repeat:(BOOL)repeat;

/**
 Initialize an interval datarule

 @param comparison Compare operation to use on incoming data
 @param constant Numerical constant used by #comparison
 @param timeout timeout in seconds
 @param repeat Save repeated values
 @return Interval datarule
 */
- (instancetype)initWithComare:(EXORpcDataruleComparison_t)comparison constant:(NSNumber*)constant timeout:(NSNumber*)timeout repeat:(BOOL)repeat;

/**
 Initialize datarule from a plist

 @param plist The property list to parse.
 @return A Datarule
 */
- (instancetype)initWithPList:(NSDictionary*)plist;

@end
