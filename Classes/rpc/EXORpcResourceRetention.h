//
//  EXORpcResourceRetention.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Retention rules for a resource
 */
@interface EXORpcResourceRetention : NSObject <NSCopying>

/**
 Maximum number of values to retain.
 
 Nil for no maximum
 */
@property(copy,nonatomic,readonly) NSNumber *count;

/**
 Only keep values within this duration.
 
 Values older than (Now - duration) are flushed.

 Nil for no duration limit
 */
@property(copy,nonatomic,readonly) NSNumber *duration;

/**
 Create a retention rule
 
 @param count Maximum number of values to retain
 @param duration Only keep values within this duration
 @return The retention rule
 */
+ (EXORpcResourceRetention*)retentionWithCount:(NSNumber*)count duration:(NSNumber*)duration;

/**
 Initialize a retention rule

 @param count Maximum number of values to retain
 @param duration Only keep values within this duration
 @return The retention rule
 */
- (instancetype)initWithCount:(NSNumber*)count duration:(NSNumber*)duration;

/**
 Return a JSON ready dictionary of the retention rule.
 */
- (NSDictionary*)plistValue;
@end
