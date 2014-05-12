//
//  EXORpcValue.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 A value read from One Platform
 
 This ties the timestamp for a value with the value.
 */
@interface EXORpcValue : NSObject <NSCopying>

/**
 When this value was recorded.
 
 This is always in UTC.
 */
@property(copy,nonatomic,readonly) NSDate *when;

/**
 The value as a string.
 
 This will always return a value.
 */
@property(copy,nonatomic,readonly) NSString *stringValue;
/**
 The value as a number.
 
 This might return nil if a string value cannot be coersed into a number.
 */
@property(copy,nonatomic,readonly) NSNumber *numberValue;

/**
 Create a new value with a string
 
 @param when The timestamp for this value.
 @param value The actual value
 @return EXORpcValue
 */
+ (EXORpcValue*)valueWithDate:(NSDate*)when string:(NSString*)value;

/**
 Create a new value with a number

 @param when The timestamp for this value.
 @param value The actual value
 @return EXORpcValue
 */
+ (EXORpcValue*)valueWithDate:(NSDate*)when number:(NSNumber*)value;

/**
 Initialize a new value with a string

 @param when The timestamp for this value.
 @param value The actual value
 @return EXORpcValue
 */
- (instancetype)initWithDate:(NSDate*)when string:(NSString*)value;

/**
 Initialize a new value with a number

 @param when The timestamp for this value.
 @param value The actual value
 @return EXORpcValue
 */
- (instancetype)initWithDate:(NSDate*)when number:(NSNumber*)value;

/**
 Return this as a plist that can be converted into JSON.

 @return JSON ready dictionary of values.
 */
- (id)plistValue;

@end
