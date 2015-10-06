//
//  EXORpcActivateRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcRequest.h"
NS_ASSUME_NONNULL_BEGIN

/**
 Request to activate a share code.
 
 @see EXORpcShareRequest
 */
@interface EXORpcActivateRequest : EXORpcRequest <NSCopying>

/**
 Is this activate request for a share code or CIK
 */
@property(assign,nonatomic,readonly) BOOL asShare;

/**
 The code to be activated
 */
@property(copy,nonatomic,readonly) NSString *code;

/**
 Callback for when request is complete.
 */
@property(copy,nonatomic,readonly) EXORpcRequestComplete complete;

/**
 Create an activate request for a share code.
 
 @param code The code to activate
 @param complete The callback to call when the request completes
 
 @return The activate request
 */
+ (EXORpcActivateRequest*)activateShareWithCode:(NSString*)code complete:(EXORpcRequestComplete)complete;

/**
 Create an activate request for a CIK.

 @param code The CIK to activate
 @param complete The callback to call when the request completes

 @return The activate request
 */
+ (EXORpcActivateRequest*)activateClientWithCode:(NSString*)code complete:(EXORpcRequestComplete)complete;

/**
 Initialize an activate request for a share code or CIK.

 @param share YES if the code is a share code, NO if it is a CIK.
 @param code The code to activate
 @param complete The callback to call when the request completes

 @return The activate request
 */
- (instancetype)initWithShare:(BOOL)share code:(NSString*)code complete:(EXORpcRequestComplete)complete;

NS_ASSUME_NONNULL_END

@end
