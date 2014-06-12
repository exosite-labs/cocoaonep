//
//  EXORpcCreateCloneRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcResource.h"

/**
 Create a clone from an existing One Platform resource given its RID or a non-activated sharecode for that resource. 
 
 The resource to clone must be a client
 */
@interface EXORpcCloneResource : EXORpcResource

/**
 The Resource Id to be cloned
 */
@property(copy,nonatomic,readonly) EXORpcResourceID *rid;

/**
 The share code to be cloned
 */
@property(copy,nonatomic,readonly) NSString *code;

/**
 Whether to clone the aliases
 */
@property(assign,nonatomic,readonly) BOOL noaliases;

/**
 Whether to clone the historical data
 */
@property(assign,nonatomic,readonly) BOOL nohistorical;

/**
 Create a clone resource for a RID
 
 @param rid The Resource Id to be cloned
 @param noaliases Whether to clone the aliases
 @param nohistory Whether to clone the historical data
 @return The clone resource
 */
+ (EXORpcCloneResource*)cloneWithRid:(EXORpcResourceID*)rid noaliases:(BOOL)noaliases nohistorical:(BOOL)nohistorical;

/**
 Create a clone resource for a share code

 @param code The share code to be cloned
 @param noaliases Whether to clone the aliases
 @param nohistory Whether to clone the historical data
 @return The clone resource
 */
+ (EXORpcCloneResource*)cloneWithCode:(NSString*)code noaliases:(BOOL)noaliases nohistorical:(BOOL)nohistorical;

/**
 Initialize a clone resource for a RID

 @param rid The Resource Id to be cloned
 @param noaliases Whether to clone the aliases
 @param nohistory Whether to clone the historical data
 @return The clone resource
 */
- (instancetype)initWithRid:(EXORpcResourceID*)rid noaliases:(BOOL)noaliases nohistorical:(BOOL)nohistorical;

/**
 Initialize a clone resource for a share code

 @param code The share code to be cloned
 @param noaliases Whether to clone the aliases
 @param nohistory Whether to clone the historical data
 @return The clone resource
 */
- (instancetype)initWithCode:(NSString*)code noaliases:(BOOL)noaliases nohistorical:(BOOL)nohistorical;

@end
