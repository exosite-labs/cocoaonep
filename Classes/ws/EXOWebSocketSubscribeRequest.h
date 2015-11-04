//
//  EXOWebSocketSubscribeRequest.h
//  Pods
//
//  Created by Michael Conrad Tadpol Tilstra on 11/4/15.
//
//

#import "EXORpcRequest.h"
#import "EXORpcValue.h"

NS_ASSUME_NONNULL_BEGIN

/**
 Callback for subscribed data

 @param value Newest value
 */
typedef void(^EXOWebSocketSubscribedValue)(EXORpcValue *value);

/**
 Request to be subscribed to a RID
 */
@interface EXOWebSocketSubscribeRequest : EXORpcRequest <NSCopying>

/**
 Callback for when RID is updated.
 */
@property(copy,nonatomic,readonly) EXOWebSocketSubscribedValue update;

/**
 Create a subscribe request to an RID.

 @param rid The reasource to subscribe to
 @param complete The callback to call when a new value is available

 @return The subscribe request
 */
+ (EXOWebSocketSubscribeRequest*)subscribeWithRID:(EXORpcResourceID*)rid update:(EXOWebSocketSubscribedValue)update;

/**
 Initialize a subscribe request to an RID.

 @param rid The reasource to subscribe to
 @param update The callback to call when a new value is available

 @return The subscribe request
 */
- (instancetype)initWithRID:(EXORpcResourceID*)rid update:(EXOWebSocketSubscribedValue)update NS_DESIGNATED_INITIALIZER;

NS_ASSUME_NONNULL_END

@end
