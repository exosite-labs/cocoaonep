//
//  EXORpcFlushRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcRequest.h"

/**
 Flush data points from a dataport.
 
 Empties the specified resource of data per specified constraints. If no constraints are specified, all data gets flushed.
 */
@interface EXORpcFlushRequest : EXORpcRequest <NSCopying>

/**
 Lower bound of data to be flushed. nil if no lower bound.
 */
@property(nonatomic,copy,readonly) NSDate *newerthan;

/**
 Upper bound of data to be flushed. nil if no upper bound.
 */
@property(nonatomic,copy,readonly) NSDate *olderthan;

/**
 Callback for when request is complete.
 */
@property(nonatomic,copy,readonly) EXORpcRequestComplete complete;

/**
 Create a flush request
 
 @param rid The resource to flush data from
 @param newerthan Lower bound of data to be flushed. nil if no lower bound.
 @param olderthan Upper bound of data to be flushed. nil if no upper bound.
 @param complete The callback to call when the request completes
 @return The flush request
 */
+ (EXORpcFlushRequest*)flushRID:(EXORpcResourceID *)rid newerThan:(NSDate*)newerthan olderThan:(NSDate*)olderthan complete:(EXORpcRequestComplete)complete;

/**
 Initialize a flush request

 @param rid The resource to flush data from
 @param newerthan Lower bound of data to be flushed. nil if no lower bound.
 @param olderthan Upper bound of data to be flushed. nil if no upper bound.
 @param complete The callback to call when the request completes
 @return The flush request
 */
- (instancetype)initWithRID:(EXORpcResourceID *)rid newerThan:(NSDate*)newerthan olderThan:(NSDate*)olderthan complete:(EXORpcRequestComplete)complete;

@end
