//
//  EXOWebSocket.h
//  Pods
//
//  Created by Michael Conrad Tadpol Tilstra on 10/29/15.
//
//

#import <Foundation/Foundation.h>
#import "EXORpcActivateRequest.h"
#import "EXORpcAuthKey.h"
#import "EXORpcClientResource.h"
#import "EXORpcCloneResource.h"
#import "EXORpcCreateRequest.h"
#import "EXORpcDataportResource.h"
#import "EXORpcDataruleResource.h"
#import "EXORpcDispatchResource.h"
#import "EXORpcDeactivateRequest.h"
#import "EXORpcDropRequest.h"
#import "EXORpcFlushRequest.h"
#import "EXORpcInfoRequest.h"
#import "EXORpcListingRequest.h"
#import "EXORpcLookupRequest.h"
#import "EXORpcMapRequest.h"
#import "EXORpcReadRequest.h"
#import "EXORpcRecordRequest.h"
#import "EXORpcRevokeRequest.h"
#import "EXORpcShareRequest.h"
#import "EXORpcUnmapRequest.h"
#import "EXORpcUpdateRequest.h"
#import "EXORpcUsageRequest.h"
#import "EXORpcValue.h"
#import "EXORpcWaitRequest.h"
#import "EXORpcWriteRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface EXOWebSocket : NSObject

/**
 Which base URL is being used for the One Platform requests.
 */
@property(nonatomic,copy,readonly) NSURL *domain;

/**
 Initialize a One Platform RPC object with a specific domain.

 @param domain Which base URL to use for the API requests. Passing nil uses the default.

 @return The RPC object
 */
- (nullable instancetype)initWithDomain:(nullable NSURL *)domain NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
