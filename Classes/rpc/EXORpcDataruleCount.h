//
//  EXORpcDataruleCount.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcDatarule.h"

/**
 Count Datarule
 
 When a value is received it is used in the comparison. If the comparison result is true and no there is no existing timeout then a timeout is started and an internal counter is set to 1. If a timeout already exists then the internal counter is incremented. If the internal counter matches the count configuration parameter, then the timeout is restarted, the internal counter is set to 0 and the condition evaluates to true. If the timeout elapses, the counter is set to 0, the timeout is cancelled and the rule outputs false.
 */
@interface EXORpcDataruleCount : EXORpcDatarule <NSCopying>

/**
 Compare operation to use on incoming data
 */
@property(nonatomic,assign,readonly) EXORpcDataruleComparison_t comparison;

/**
 Numerical constant used by #comparison
 */
@property(nonatomic,copy,readonly) NSNumber *constant;

/**
 The number of data points accumulated that satisfy the #comparison
 */
@property(nonatomic,copy,readonly) NSNumber *count;

/**
 Timeout in seconds
 */
@property(nonatomic,copy,readonly) NSNumber *timeout;

/**
 Specifies whether output from this rule should be written to its data stack if it is the same as the latest value already on the data stack. If set to true, the output of this rule is always written to the rule's data stack. If set to false, a output is only written if it is different from the previous value.
 */
@property(nonatomic,assign,readonly) BOOL repeat;

/**
 Create a count datarule

 @param comparison Compare operation to use on incoming data
 @param constant Numerical constant used by #comparison
 @param count The number of data points accumulated that satisfy the #comparison
 @param timeout timeout in seconds
 @param repeat Save repeated values
 @return Count datarule
 */
+ (EXORpcDataruleCount*)dataruleCountWithCompare:(EXORpcDataruleComparison_t)comparison constant:(NSNumber*)constant count:(NSNumber*)count timeout:(NSNumber*)timeout repeat:(BOOL)repeat;

/**
 Initialize a count datarule

 @param comparison Compare operation to use on incoming data
 @param constant Numerical constant used by #comparison
 @param count The number of data points accumulated that satisfy the #comparison
 @param timeout timeout in seconds
 @param repeat Save repeated values
 @return Count datarule
 */
- (instancetype)initWithCompare:(EXORpcDataruleComparison_t)comparison constant:(NSNumber*)constant count:(NSNumber*)count timeout:(NSNumber*)timeout repeat:(BOOL)repeat;

/**
 Initialize datarule from a plist

 @param plist The property list to parse.
 @return A Datarule
 */
- (instancetype)initWithPList:(NSDictionary*)plist;

@end
