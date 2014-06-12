//
//  EXORpcRevokeRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcRequest.h"

/**
 Given an activation code, the associated entity is revoked after which the activation code can no longer be used.
 
 The calling client must be the owner of the resource with which the activation code is associated.
 */
@interface EXORpcRevokeRequest : EXORpcRequest <NSCopying>

/**
 Revoking a share code or RID
 */
@property(assign,nonatomic,readonly) BOOL asShare;

/**
 The activation code to revoke.
 */
@property(strong,nonatomic,readonly) NSString *code;

/**
 Callback when finished
 */
@property(copy,nonatomic,readonly) EXORpcRequestComplete complete;

/**
 Create a revoke request
 
 @param code The activation code to revoke
 @param asShare Is the activation code a share code or client code
 @param complete Callback when request completes
 @return The revoke request
 */
+ (EXORpcRevokeRequest*)revokeWithCode:(NSString*)code asShare:(BOOL)asShare complete:(EXORpcRequestComplete)complete;

/**
 Initialize a revoke request

 @param code The activation code to revoke
 @param asShare Is the activation code a share code or client code
 @param complete Callback when request completes
 @return The revoke request
 */
- (instancetype)initWithCode:(NSString*)code asShare:(BOOL)asShare complete:(EXORpcRequestComplete)complete;

@end
