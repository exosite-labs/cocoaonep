//
//  EXORpcShareRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcRequest.h"

/**
 Callback with the new share code.
 
 @param shareCode The new share code, or nil on error
 @param error nil on success, or the reason for failure
 */
typedef void(^EXORpcShareRequestComplete)(NSString *shareCode, NSError *error);

/**
 Generates a share code for the given resource.
 
 The share code can subsequently be used to activate the share and gain access to the shared resource.
 */
@interface EXORpcShareRequest : EXORpcRequest <NSCopying>

/**
 Callback when finished
 */
@property(copy,nonatomic,readonly) EXORpcShareRequestComplete complete;

/**
 Meta data about the schare request
 */
@property(copy,nonatomic,readonly) NSString *meta;

/**
 Create a share request
 
 @param rid The resource to be shared
 @param meta Meta data describing the share
 @param complete Callback when finished
 @return The share request
 */
+ (EXORpcShareRequest*)shareWithRID:(EXORpcResourceID*)rid meta:(NSString*)meta complete:(EXORpcShareRequestComplete)complete;

/**
 Create a share request

 @param rid The resource to be shared
 @param complete Callback when finished
 @return The share request
 */
+ (EXORpcShareRequest*)shareWithRID:(EXORpcResourceID*)rid complete:(EXORpcShareRequestComplete)complete;

/**
 Initialize a share request

 @param rid The resource to be shared
 @param meta Meta data describing the share
 @param complete Callback when finished
 @return The share request
 */
- (instancetype)initWithRID:(EXORpcResourceID *)rid meta:(NSString*)meta complete:(EXORpcShareRequestComplete)complete;

@end
