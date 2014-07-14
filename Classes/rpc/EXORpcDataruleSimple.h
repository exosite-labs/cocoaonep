//
//  EXORpcDataruleSimple.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcDatarule.h"

/**
 A simple datarule

 Values received by this rule are compared to a numerical constant and the result is the boolean result of that comparison.
 */
@interface EXORpcDataruleSimple : EXORpcDatarule <NSCopying>
/**
 Compare operation to use on incoming data
 */
@property(nonatomic,assign,readonly) EXORpcDataruleComparison_t comparison;

/**
 Numerical constant used by #comparison
 */
@property(nonatomic,copy,readonly) NSNumber *constant;

/**
 Specifies whether new inputs that would not change the output should be written to the output data stack anyway. If set to true, the output of this rule is always written to the rule's data stack. If set to false, a output is only written if it's different from the previous value.
 */
@property(nonatomic,assign,readonly) BOOL repeat;

/**
 Create a simple datarule
 
 @param comparison Compare operation to use on incoming data
 @param constant Numerical constant used by #comparison
 @param repeat Save repeated values
 @return Simple datarule
 */
+ (EXORpcDataruleSimple*)dataruleSimpleWithCompare:(EXORpcDataruleComparison_t)comparison constant:(NSNumber*)constant repeat:(BOOL)repeat;

/**
 Initialze a simple datarule

 @param comparison Compare operation to use on incoming data
 @param constant Numerical constant used by #comparison
 @param repeat Save repeated values
 @return Simple datarule
 */
- (instancetype)initWithCompare:(EXORpcDataruleComparison_t)comparison constant:(NSNumber*)constant repeat:(BOOL)repeat;

/**
 Initialize datarule from a plist

 @param plist The property list to parse.
 @return A Datarule
 */
- (instancetype)initWithPList:(NSDictionary*)plist;

@end
