//
//  EXORpcWaitRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//
//

#import "EXORpcRequest.h"

/**
 Callback for completed wait

 @param results If successful, an EXORpcValue, otherwise nil
 @param error If successful, is nil, otherwise the error.
 
 It is common to see a #kEXORpcErrorTypeExpired error.  This means the call timed out without receiving a new value.
 */
typedef void(^EXORpcWaitRequestComplete)(NSDictionary* results, NSError *error);



/**
 Request to wait for a new value
 */
@interface EXORpcWaitRequest : EXORpcRequest <NSCopying>

/**
 The Resource ID to wait for new data on.
 @note The current One Platform implementation only supports a single RID.
 */
@property (copy,nonatomic,readonly) NSArray *resourceIDs;

/**
 The maximum amount of time to wait for a new value before timing out.
 
 If nil, use the server's default timeout value. (30 seconds)
 */
@property (copy,nonatomic,readonly) NSNumber *timeout;

/**
 Timestamp to filter waited value for.
 Only new values after this will trigger the reply.
 
 If nil, then the default of when the request was made.
 */
@property (copy,nonatomic,readonly) NSDate *since;

/**
 The callback for when the operation is complete.
 */
@property (copy,nonatomic,readonly) EXORpcWaitRequestComplete complete;

/**
 Wait for values from the given RIDs.
 \note Only supports a single RID currently!  RIDs beyond 0 are ignored.

 @param rids RIDs to wait on.
 @param complete The callback when complete.
 @return The Wait Request
 */
+ (EXORpcWaitRequest*)waitRequestWithRIDs:(NSArray*)rids complete:(EXORpcWaitRequestComplete)complete;

/**
 Wait for values from the given RIDs.
 \note Only supports a single RID currently!  RIDs beyond 0 are ignored.

 @param rids RIDs to wait on.
 @param timeout The maximum amount of time to wait for a new value before timing out.
 @param complete The callback when complete.
 @return The Wait Request
 */
+ (EXORpcWaitRequest*)waitRequestWithRIDs:(NSArray*)rids timeoutAfter:(NSNumber*)timeout complete:(EXORpcWaitRequestComplete)complete;

/**
 Wait for values from the given RIDs.
 \note Only supports a single RID currently!  RIDs beyond 0 are ignored.

 @param rids RIDs to wait on.
 @param timeout The maximum amount of time to wait for a new value before timing out.
 @param since Timestamp to filter waited value for.
 @param complete The callback when complete.
 @return The Wait Request
 */
+ (EXORpcWaitRequest*)waitRequestWithRIDs:(NSArray*)rids timeoutAfter:(NSNumber*)timeout since:(NSDate*)since complete:(EXORpcWaitRequestComplete)complete;


/**
 Wait for values from the given RIDs.
 \note Only supports a single RID currently!  RIDs beyond 0 are ignored.

 @param rids RIDs to wait on.
 @param timeout The maximum amount of time to wait for a new value before timing out.
 @param since Timestamp to filter waited value for.
 @param complete The callback when complete.
 */
- (instancetype)initWithRIDs:(NSArray*)rids timeoutAfter:(NSNumber*)timeout since:(NSDate*)since complete:(EXORpcWaitRequestComplete)complete;

@end
