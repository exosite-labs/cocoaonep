//
//  EXORpcUnmapRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcRequest.h"

/**
 Request to unmap an alias from an RID
 */
@interface EXORpcUnmapRequest : EXORpcRequest <NSCopying>

/**
 The alias to unmap
 */
@property(copy,nonatomic,readonly) NSString *alias;

/**
 Callback for when complete
 */
@property(copy,nonatomic,readonly) EXORpcRequestComplete complete;

/**
 Create a request to unmap an alias on the client.

 @param alias The Alias to unmap
 @param complete Callback whn finished
 @return Uname Request
 */
+ (EXORpcUnmapRequest*)unmapWithAlias:(NSString*)alias complete:(EXORpcRequestComplete)complete;

/**
 Initialize a request to unmap an alias on the client at RID.

 @param alias The Alias to unmap
 @param complete Callback whn finished
 @return Uname Request
 */
- (instancetype)initWithAlias:(NSString*)alias complete:(EXORpcRequestComplete)complete;

@end
