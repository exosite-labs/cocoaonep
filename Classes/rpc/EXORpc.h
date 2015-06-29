//
//  EXORpc.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
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
/**
 Key for Errors specific to EXORpc.
 */
extern NSString *EXORpcDeviceErrorDomain;

/**
 Callback for the completion of a RPC exchange
 
 @param err If not nil, then the error generated by the failed network calls
 */
typedef void(^EXORpcRPCComplete)(NSError * __nullable error);

/**
 Called when network usage is started or stopped.
 
 @param active YES when the network is being used, FALSE when it is done.
 
 This is primarily intended for turning on or off the Network Activity Indicator.
 
 For example:
     onep.activityChange = ^(BOOL active){
        [UIApplication sharedApplication].networkActivityIndicatorVisible = active;
     };

 */
typedef void(^EXORpcActivityChange)(BOOL active);

/**
 The RPC
 */
@interface EXORpc : NSObject

/**
 Which base URL is being used for the One Platform requests.
 */
@property(nonatomic,copy,readonly) NSURL *domain;

/**
 Which queue to do background work on.
 
 Defaults to the Main Queue.
 */
@property(nonatomic,strong) NSOperationQueue *queue;

/**
 Callback for when network usage status changes.
 */
@property(nonatomic,copy) EXORpcActivityChange activityChange;

/**
 Create a One Platform RPC object with the default values.
 
 @return The RPC object
 */
+ (EXORpc*)rpc;

/**
 Create a One Platform RPC object with a specific domain.
 
 @param domain Which base URL to use for the API requests. Passing nil uses the default.

 @return The RPC object
*/
+ (EXORpc*)rpcWithDomain:(nullable NSURL*)domain;

/**
 Initialize a One Platform RPC object with a specific domain.

 @param domain Which base URL to use for the API requests. Passing nil uses the default.

 @return The RPC object
 */
- (instancetype)initWithDomain:(nullable NSURL *)domain;

/**
 Creates and queues a NSOperation for a set of calls to One Platform

 @see operationWithAuth:requests:complete

 */
- (void)doRPCwithAuth:(EXORpcAuthKey*)auth requests:(NSArray<EXORpcRequest *> *)calls complete:(EXORpcRPCComplete)complete;

/**
 Create a NSOperation for a set of calls to One Platform
 
 This represents a single HTTP request - response pair.  All of the requests in the array are formed into a single HTTP request and sent to the One Platform.  The response is then parsed and each call given its results to handle in its own way.  After all of the request callbacks are called, the complete callback is called.

 The order of the request callbacks is not guaranteed, but it is guaranteed that all of them will execute before this complete callback.
 Also, if the error parameter to this complete callback is not nil, then none of the request callback were called.
 
 @param auth One Platform authentication to a client
 @param calls NSArray of object that subclass from EXORpcRequest
 @param complete Callback called once all requests are handled or on network errors
 
 @return NSOperation of the packaged API request
 */
- (NSOperation *)operationWithAuth:(EXORpcAuthKey *)auth requests:(NSArray<EXORpcRequest *> *)calls complete:(EXORpcRPCComplete)complete;

@end
NS_ASSUME_NONNULL_END
