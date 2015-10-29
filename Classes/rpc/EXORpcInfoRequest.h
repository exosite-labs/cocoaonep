//
//  EXORpcInfoRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014-2015 Exosite. All rights reserved.
//

#import "EXORpcRequest.h"

NS_ASSUME_NONNULL_BEGIN

/**
 Types of information that can be requested.
 
 Not all types exist on all resoruces.
 */
typedef NS_ENUM(NSUInteger, EXORpcInfoRequestType) {
    EXORpcInfoRequestTypeAliases = 1 << 0,      /// All aliases associated with the calling client's child resources
    EXORpcInfoRequestTypeBasic = 1 << 1,        /// Basic information about a resource, such as its type, when it was created, last modified and, for 'client' and 'dispatch' type resources, its current status
    EXORpcInfoRequestTypeComments = 1 << 2,     /// This is deprecated and should not be used
    EXORpcInfoRequestTypeCounts = 1 << 3,       /// The actual count of the resources/consumables used
    EXORpcInfoRequestTypeDescription = 1 << 4,  /// The description of the resource that was used to create or last update the resource
    EXORpcInfoRequestTypeKey = 1 << 5,          /// The Client Interface Key (CIK) associated with the resource. This is valid for client resources only.
    EXORpcInfoRequestTypeShares = 1 << 6,       /// Share activation codes along with information about how many times and for what duration this resource has been shared and which clients the activators are
    EXORpcInfoRequestTypeTagged = 1 << 7,       /// Reserved for future use
    EXORpcInfoRequestTypeTags = 1 << 8,         /// Reserved for future use
    EXORpcInfoRequestTypeUsage = 1 << 9,        /// Current usage information for the resource
    EXORpcInfoRequestTypeAll = 0,               /// Return all information about the resource
    };

/**
 Callback with results of information request
 
 @param result The information request, or nil if error.
 @param error The error or nil if success.
 */
typedef void(^EXORpcInfoRequestComplete)(NSDictionary * __nullable result, NSError * __nullable error);

/**
 Request Infomation about a resource

 Request creation and usage information of specified resource according to the specified options. Information is returned for the options specified. If no option is specified, a full information report is returned.
*/
@interface EXORpcInfoRequest : EXORpcRequest <NSCopying>

/**
 Types of info requested.
 */
@property(nonatomic,assign,readonly) EXORpcInfoRequestType types;

/**
 Callback for when request is complete.
 */
@property(nonatomic,copy,readonly) EXORpcInfoRequestComplete complete;

/**
 When true, returned results are nested base foundation types.
 
 When false, returned results will be EXORpc types when possible.
 */
@property(assign,nonatomic,readonly) BOOL returnRaw;

/**
 Create an Information request
 
 @param rid The resource to request info about
 @param types What info to request
 @param complete Callback for when request is complete
 @return The info request
 */
+ (EXORpcInfoRequest*)infoByRID:(EXORpcResourceID *)rid types:(EXORpcInfoRequestType)types complete:(EXORpcInfoRequestComplete)complete;

/**
 Initialize an Information request

 @param rid The resource to request info about
 @param types What info to request
 @param raw Return results as base foundation types.
 @param complete Callback for when request is complete
 @return The info request
 */
- (instancetype)initWithRID:(EXORpcResourceID *)rid types:(EXORpcInfoRequestType)types raw:(BOOL)raw complete:(EXORpcInfoRequestComplete)complete;

NS_ASSUME_NONNULL_END

@end
