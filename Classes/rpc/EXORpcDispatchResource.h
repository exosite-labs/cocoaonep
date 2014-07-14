//
//  EXORpcCreateDispatchRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcResource.h"
#import "EXORpcResourceRetention.h"
#import "EXORpcPreprocessOperation.h"

enum EXORpcDispactMethod_e {
    EXORpcDispactMethodEmail, /// Dispatch an Email
    EXORpcDispactMethodHttpGet, /// Placeholder, do not use.
    EXORpcDispactMethodHttpPost,/// Placeholder, do not use.
    EXORpcDispactMethodHttpPut, /// Placeholder, do not use.
    EXORpcDispactMethodSms, /// Dispatch an SMS
    EXORpcDispactMethodXmpp, /// Dispatch a message via XMPP
};
/**
 Type of dispatch.
 */
typedef enum EXORpcDispactMethod_e EXORpcDispactMethod_t;

/**
 A Dispatch Resource
 */
@interface EXORpcDispatchResource : EXORpcResource <NSCopying>

/**
 The method by which this dispatch is sent.
 */
@property(assign,nonatomic,readonly) EXORpcDispactMethod_t method;

@property(assign,nonatomic,readonly) BOOL locked;

/**
 The message to send.
 If nil, the current value will be sent
 */
@property(copy,nonatomic,readonly) NSString *message;


@property(copy,nonatomic,readonly) NSArray *preprocess;

/**
 Where to send the message.
 
 Must be a vaild email address for email dispacthes or phone number for SMS dispatches.
 */
@property(copy,nonatomic,readonly) NSString *recipient;

/**
 Data retention limits for this dispatch
 */
@property(copy,nonatomic,readonly) EXORpcResourceRetention *retention;

/**
 For email dispatches, the subject line
 */
@property(copy,nonatomic,readonly) NSString *subject;

/**
 The resource watched for changes to dispatch on.
 */
@property(copy,nonatomic,readonly) EXORpcResourceID *subscribe;

/**
 Create an Email dispatch

 @param recipient Who gets the dispatch
 @param subject The subject of email dispatches
 @param message The message in the dispatch
 @param subscribed The resource to watch for changes

 @return A Dispatch Resource
*/
+ (EXORpcDispatchResource*)dispatchEmailTo:(NSString*)recipient subject:(NSString*)subject message:(NSString*)message on:(EXORpcResourceID*)subscribed;

/**
 Create a SMS dispatch
 
 @param recipient Who gets the dispatch
 @param message The message in the dispatch
 @param subscribed The resource to watch for changes

 @return A Dispatch Resource
 */
+ (EXORpcDispatchResource*)dispatchSMSTo:(NSString*)recipient message:(NSString*)message on:(EXORpcResourceID*)subscribed;

/**
 Create a new dispatch
 
 @param name Name of this dispatch
 @param method Which method to dispatch
 @param recipient Who gets the dispatch
 @param subject The subject of email dispatches
 @param message The message in the dispatch
 @param subscribed The resource to watch for changes
 
 @return A Dispatch Resource
 */
+ (EXORpcDispatchResource*)dispatchWithName:(NSString*)name method:(EXORpcDispactMethod_t)method to:(NSString*)recipient subject:(NSString*)subject message:(NSString*)message on:(EXORpcResourceID*)subscribed;

/**
 Initialize a dispatch

 @param name Name of this dispatch
 @param meta Metadata for this dispatch
 @param method Which method to dispatch
 @param recipient Who gets the dispatch
 @param subject The subject of email dispatches
 @param message The message in the dispatch
 @param subscribed The resource to watch for changes
 @param locked If YES, this will not send out messages
 @param public If YES, this can be read by any client
 @param preprocess Operations to be performed on incoming data.
 @param retention Retention rules for the data

 @return A Dispatch Resource
 */
- (instancetype)initWithName:(NSString*)name meta:(NSString*)meta method:(EXORpcDispactMethod_t)method to:(NSString*)recipient subject:(NSString*)subject message:(NSString*)message on:(EXORpcResourceID*)subscribed locked:(BOOL)locked public:(BOOL)public preprocess:(NSArray*)preprocess retention:(EXORpcResourceRetention*)retention;

/**
 Initialize a dispatch resource from a plist from info request.

 @param plist The description property list from an info request.
 @return A Dispatch Resource
 */
- (instancetype)initWithPList:(NSDictionary*)plist;

@end
