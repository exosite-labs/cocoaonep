//
//  EXORpcRecordRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcRequest.h"
#import "EXORpcValue.h"

/**
 Records a list of historical entries
 */
@interface EXORpcRecordRequest : EXORpcRequest <NSCopying>
@property(strong,nonatomic,readonly) NSArray *values;  //// Array of EXORpcValues to record
@property(copy,nonatomic,readonly) EXORpcRequestComplete complete; /// Callback when complete

/**
 Create a request to record a list of values
 
 @param rid The resource to write the values to
 @param value Array of EXORpcValues to be recorded
 @param complete Callback when finished
 @return The record request
 */
+ (EXORpcRecordRequest*)recordWithRID:(EXORpcResourceID *)rid values:(NSArray*)values complete:(EXORpcRequestComplete)complete;

/**
 Initialize a request to record a list of values

 @param rid The resource to write the values to
 @param value Array of EXORpcValues to be recorded
 @param complete Callback when finished
 @return The record request
 */
- (instancetype)initWithRID:(EXORpcResourceID *)rid values:(NSArray*)values complete:(EXORpcRequestComplete)complete;

@end
