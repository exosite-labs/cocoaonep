//
//  EXORpcDropRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcRequest.h"

/**
 Deletes the specified resource.
 
 If the resource is a client, the client's subhierarchy are deleted, too. If the resource is a script type datarule, or the hierarchy being dropped contains scripts, the script will be terminated.
 */
@interface EXORpcDropRequest : EXORpcRequest <NSCopying>

/**
 Callback for when request is complete.
 */
@property(nonatomic,copy,readonly) EXORpcRequestComplete complete;

/**
 Create a Drop Request
 
 @param rid Resource ID of resource to be deleted
 @param complete The callback to call when the request completes
 @return The drop request
 */
+ (EXORpcDropRequest*) dropWithRID:(EXORpcResourceID *)rid complete:(EXORpcRequestComplete)complete;

/**
 Initialize a Drop Request

 @param rid Resource ID of resource to be deleted
 @param complete The callback to call when the request completes
 @return The drop request
 */
- (instancetype)initWithRID:(EXORpcResourceID *)rid complete:(EXORpcRequestComplete)complete;

@end
