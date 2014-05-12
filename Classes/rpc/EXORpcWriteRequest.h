//
//  EXORpcWriteRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EXORpcRequest.h"
#import "EXORpcValue.h"

/**
 A request to write a value
 */
@interface EXORpcWriteRequest : EXORpcRequest <NSCopying>
/**
 The value that will be written
 */
@property(nonatomic,copy,readonly) NSString *value;

/**
 The callback after the value has been written
 */
@property(nonatomic,copy,readonly) EXORpcRequestComplete complete;

/**
 Create a write request for a string
 
 @param rid The dataport resource to write to
 @param value The value to write
 @param complete The callback after the value has been written
 
 @return
 */
+ (EXORpcWriteRequest*)writeWithRID:(EXORpcResourceID*)rid string:(NSString*)value complete:(EXORpcRequestComplete)complete;

/**
 Create a write request for a number

 @param rid The dataport resource to write to
 @param value The value to write
 @param complete The callback after the value has been written

 @return
 */
+ (EXORpcWriteRequest*)writeWithRID:(EXORpcResourceID*)rid number:(NSNumber*)value complete:(EXORpcRequestComplete)complete;

/**
 Create a write request for a JSON ready plist

 @param rid The dataport resource to write to
 @param value The value to write
 @param complete The callback after the value has been written

 @return
 */
+ (EXORpcWriteRequest*)writeWithRID:(EXORpcResourceID*)rid plist:(id)value complete:(EXORpcRequestComplete)complete;

/**
 Create a write request for an EXORpcValue

 @param rid The dataport resource to write to
 @param value The value to write
 @param complete The callback after the value has been written

 @warning The `when` property on the EXORpcValue is ignored by write.  Use EXORpcRecord if you want to also set the timestamp.

 @return
 */
+ (EXORpcWriteRequest*)writeWithRID:(EXORpcResourceID*)rid value:(EXORpcValue*)value complete:(EXORpcRequestComplete)complete;

/**
 Create a write request for a string

 @param rid The dataport resource to write to
 @param value The value to write
 @param complete The callback after the value has been written

 @return
 */
- (instancetype)initWithRID:(EXORpcResourceID*)rid value:(NSString*)value complete:(EXORpcRequestComplete)complete;

@end
