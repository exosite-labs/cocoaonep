//
//  EXORpcCreateRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014-2015 Exosite. All rights reserved.
//

#import "EXORpcRequest.h"
#import "EXORpcResource.h"

NS_ASSUME_NONNULL_BEGIN

/**
 Callback for completed create resource request.
 
 @param RID A resource identifier for the newly created resource. On error, will be nil.
 @param error An error why the create failed. Is nil on success.
 */
typedef void(^EXORpcCreateRequestComplete)(EXORpcResourceID * __nullable RID, NSError * __nullable error);

/**
 A request to create a new resource.
 */
@interface EXORpcCreateRequest : EXORpcRequest <NSCopying>

/**
 The resource to create
 */
@property(nonatomic,copy,readonly) EXORpcResource *resource;

/**
 The callback for when the request completes
 */
@property(nonatomic,copy,readonly) EXORpcCreateRequestComplete complete;

/**
 Create a create request.
 
 @param resource The resource to create
 @param complete The callback
 @return A Create Request
 */
+ (nullable EXORpcCreateRequest*)createWithResource:(EXORpcResource*)resource complete:(EXORpcCreateRequestComplete)complete;

/**
 Initialize a create request.

 @param resource The resource to create
 @param complete The callback
 @return A Create Request
 */
- (instancetype)initWithResource:(EXORpcResource*)resource complete:(EXORpcCreateRequestComplete)complete;

NS_ASSUME_NONNULL_END

@end
