//
//  EXORpcUpdateRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcRequest.h"
#import "EXORpcResource.h"

/**
 Updates the description of the resource.
 */
@interface EXORpcUpdateRequest : EXORpcRequest <NSCopying>

/**
 The new details to update the resource with
 */
@property(nonatomic,copy,readonly) EXORpcResource *resource;

/**
 Callback for complete
 */
@property(nonatomic,copy,readonly) EXORpcRequestComplete complete;

/**
 Create an update request
 
 @param rid The resource to update
 @param resource The new details to update the resource with
 @param complete Callback for when update is complete
 @return The update request
 */
+ (EXORpcUpdateRequest*)updateWithRID:(EXORpcResourceID*)rid resource:(EXORpcResource*)resource complete:(EXORpcRequestComplete)complete;

/**
 Initialize an update request

 @param rid The resource to update
 @param resource The new details to update the resource with
 @param complete Callback for when update is complete
 @return The update request
 */
- (instancetype)initWithRID:(EXORpcResourceID*)rid resource:(EXORpcResource*)resource complete:(EXORpcRequestComplete)complete;

/**
 Get the request as a dictionary that is JSON clean

 @return A dictionary representation of the request.
 */
- (NSDictionary *)plistValue;

@end
