//
//  EXORpcReadRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcRequest.h"
#import "EXORpcValue.h"
NS_ASSUME_NONNULL_BEGIN

/**
 Read Selection downsampling type.
 
 @note Note that these options provide a blind sampling function, not averaging or other type of rollup calculation.
 */
enum EXORpcReadSelectionType {
    EXORpcReadSelectionTypeAll, /// Return all data points.
    EXORpcReadSelectionTypeGivenWindow, /// Split time window evenly into "limit" parts and returns at most one point from each part.
    EXORpcReadSelectionTypeAutoWindow /// Samples evenly across points in the time window up to "limit".
};
typedef enum EXORpcReadSelectionType EXORpcReadSelectionType_t;

/**
 Callback for completed read
 
 @param results If successful, an array of EXORpcValues, otherwise nil
 @param error If successful, is nil, otherwise the error.
 */
typedef void(^EXORpcReadRequestComplete)(NSArray<EXORpcValue *> * __nullable results, NSError* __nullable error);

/**
 A request to read values
 */
@interface EXORpcReadRequest : EXORpcRequest <NSCopying>

/**
 The timestamp to start reading values from
 
 This should always be older than endtime. (or nil)
 */
@property(nonatomic,strong,readonly,nullable) NSDate *starttime;

/**
 The timestamp to stop reading values from

 This should always be newer than starttime. (or nil)
 */
@property(nonatomic,strong,readonly,nullable) NSDate *endtime;

/**
 Consider the data values in ascending or decending order before applying selection or limits.
 */
@property(nonatomic,assign,readonly) BOOL sortAscending;

/**
 Maximum number of values to return
 */
@property(nonatomic,assign,readonly) NSUInteger limit;

/**
 The applied selection downsampling filter.
 */
@property(nonatomic,assign,readonly) EXORpcReadSelectionType_t selection;

/**
 The callback for when the operation is complete.
 */
@property(nonatomic,copy,readonly) EXORpcReadRequestComplete complete;

/**
 Read the most recent value from the given RID.
 
 @param rid Dataport to read
 @param complete The callback when complete.
 @return The Read Request
 */
+ (EXORpcReadRequest*)readWithRID:(EXORpcResourceID*)rid complete:(EXORpcReadRequestComplete)complete;

/**
 Read values from the given RID.

 @param rid Dataport to read.
 @param startime The timestamp to start reading values from.
 @param endtime The timestamp to stop reading values from.
 @param ascending Consider the data values in ascending or decending order before applying selection or limits.
 @param limit Maximum number of values to return.
 @param selection The selection downsampling filter to use.
 @param complete The callback when complete.
 @return The Read Request
 */
+ (EXORpcReadRequest*)readWithRID:(EXORpcResourceID*)rid startTime:(nullable NSDate*)starttime endTime:(nullable NSDate*)endtime ascending:(BOOL)ascending limit:(NSUInteger)limit selection:(EXORpcReadSelectionType_t)selection complete:(EXORpcReadRequestComplete)complete;

/**
 Read the most recent value from the given RID.

 @param rid Dataport to read
 @param complete The callback when complete.
 @return The Read Request
 */
- (instancetype)initWithRID:(EXORpcResourceID*)rid complete:(EXORpcReadRequestComplete)complete;

/**
 Read values from the given RID.

 @param rid Dataport to read.
 @param startime The timestamp to start reading values from.
 @param endtime The timestamp to stop reading values from.
 @param ascending Consider the data values in ascending or decending order before applying selection or limits.
 @param limit Maximum number of values to return.
 @param selection
 @param complete The callback when complete.

 */
- (instancetype)initWithRID:(EXORpcResourceID*)rid startTime:(nullable NSDate*)starttime endTime:(nullable NSDate*)endtime ascending:(BOOL)ascending limit:(NSUInteger)limit selection:(EXORpcReadSelectionType_t)selection complete:(EXORpcReadRequestComplete)complete;

NS_ASSUME_NONNULL_END

@end
