//
//  EXORpcDeactivateRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcRequest.h"

/**
 Deactivate a given Activation code
 */
@interface EXORpcDeactivateRequest : EXORpcRequest <NSCopying>

/**
 Is this deactivate request for a share code or CIK
 */
@property(nonatomic,assign,readonly) BOOL asShare;

/**
 The code to be deactivated
 */
@property(nonatomic,copy,readonly) NSString *code;

/**
 Callback for when request is complete.
 */
@property(nonatomic,copy,readonly) EXORpcRequestComplete complete;

/**
 Create an deactivate request for a share code.

 @param code The code to deactivate
 @param complete The callback to call when the request completes

 @return The deactivate request
 */
+ (EXORpcDeactivateRequest*)deactivateShareWithCode:(NSString*)code complete:(EXORpcRequestComplete)complete;

/**
 Create an deactivate request for a CIK.

 @param code The CIK to deactivate
 @param complete The callback to call when the request completes

 @return The deactivate request
 */
+ (EXORpcDeactivateRequest*)deactivateClientWithCode:(NSString*)code complete:(EXORpcRequestComplete)complete;

/**
 Initialize an deactivate request for a share code or CIK.

 @param share YES if the code is a share code, NO if it is a CIK.
 @param code The code to deactivate
 @param complete The callback to call when the request completes

 @return The deactivate request
 */
- (instancetype)initWithShare:(BOOL)asShare code:(NSString*)code complete:(EXORpcRequestComplete)complete;

@end
