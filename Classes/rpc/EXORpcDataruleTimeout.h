//
//  EXORpcDataruleTimeout.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcDatarule.h"

/**
 Timeout datarule

 Output true if no input value is received within a timeout period. If an input value is received within the period, output false. The timer is restarted when an input value is received, when the timeout elapses and when the script is first started.

*/
@interface EXORpcDataruleTimeout : EXORpcDatarule <NSCopying>

/**
 Timeout in seconds
 */
@property(nonatomic,copy,readonly) NSNumber *timeout;

/**
 Specifies whether new inputs that would not change the output should be written to the output data stack anyway. If set to true, the output of this rule is always written to the rule's data stack. If set to false, a output is only written if it's different from the previous value.
 */
@property(nonatomic,assign,readonly) BOOL repeat;

/**
 Create a timeout datarule

 @param timeout timeout in seconds
 @param repeat Save repeated values
 @return Timeout datarule
 */
+ (EXORpcDataruleTimeout*)dataruleTimeoutWithTimeout:(NSNumber*)timeout repeat:(BOOL)repeat;

/**
 Initialize a timeout datarule

 @param timeout timeout in seconds
 @param repeat Save repeated values
 @return Timeout datarule
 */
- (instancetype)initWithTimeout:(NSNumber*)timeout repeat:(BOOL)repeat;

/**
 Initialize datarule from a plist

 @param plist The property list to parse.
 @return A Datarule
 */
- (instancetype)initWithPList:(NSDictionary*)plist;

@end
