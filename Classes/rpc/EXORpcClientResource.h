//
//  EXORpcCreateClientRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcResource.h"

/**
 A client resource
 */
@interface EXORpcClientResource : EXORpcResource

/**
 If set to true, prevents this client from interacting with the One Platform. Every API call will return the error code "locked".
 */
@property(assign,nonatomic,readonly) BOOL locked;

/**
 How many clients this client can own.
 
 Nil to inherit limit from parent.
 */
@property(copy,nonatomic,readonly) NSNumber *limitClient;

/**
 How many dataports this client can own.

 Nil to inherit limit from parent.
 */
@property(copy,nonatomic,readonly) NSNumber *limitDataport;

/**
 How many datarules this client can own.

 Nil to inherit limit from parent.
 */
@property(copy,nonatomic,readonly) NSNumber *limitDatarule;

/**
 How much disk space this cleint may used.

 Nil to inherit limit from parent.
 */
@property(copy,nonatomic,readonly) NSNumber *limitDisk;

/**
 How many dispatches this client can own.

 Nil to inherit limit from parent.
 */
@property(copy,nonatomic,readonly) NSNumber *limitDispatch;

/**
 How requests can be made to this client per day.

 Nil to inherit limit from parent.
 */
@property(copy,nonatomic,readonly) NSNumber *limitIO;

/**
 How many emails this client can send per day.

 Nil to inherit limit from parent.
 */
@property(copy,nonatomic,readonly) NSNumber *limitEmail;

/**
 The number of emails that can be sent.

 Nil to inherit limit from parent.
 */
@property(copy,nonatomic,readonly) NSNumber *limitEmailBucket;

/**
 How many http requests this client can send per day.

 Nil to inherit limit from parent.
 */
@property(copy,nonatomic,readonly) NSNumber *limitHttp;

/**
 The number of HTTP Requests that can be sent.

 Nil to inherit limit from parent.
 */
@property(copy,nonatomic,readonly) NSNumber *limitHttpBucket;

/**
 How many shares this client can create.

 Nil to inherit limit from parent.
 */
@property(copy,nonatomic,readonly) NSNumber *limitShare;

/**
 How many SMSes this client can send per day.

 Nil to inherit limit from parent.
 */
@property(copy,nonatomic,readonly) NSNumber *limitSms;

/**
 The number of SMSes that can be sent.

 Nil to inherit limit from parent.
 */
@property(copy,nonatomic,readonly) NSNumber *limitSmsBucket;

/**
 How many XMPPs this client can send per day.

 Nil to inherit limit from parent.
 */
@property(copy,nonatomic,readonly) NSNumber *limitXmpp;

/**
 The number of XMPPs that can be sent.

 Nil to inherit limit from parent.
 */
@property(copy,nonatomic,readonly) NSNumber *limitXmppBucket;


/**
 Create a client resource

 @param name Name of this client
 @param meta Meta data for this client
 @param public Provides public read-only access to the resource
 @param locked Prevents this client from interaction
 @param limits Dictionary of limits to set. Keys are the names of each limit.
 @return A Client Resource
 */
+ (EXORpcClientResource*)resourceWithName:(NSString *)name meta:(NSString *)meta public:(BOOL)public locked:(BOOL)locked limits:(NSDictionary*)limits;

/**
 Create a client resource
 
 @param name Name of this client
 @param meta Meta data for this client
 @return A Client Resource
 */
+ (EXORpcClientResource*)resourceWithName:(NSString *)name meta:(NSString *)meta;

/**
 Initialize a client resource

 @param name Name of this client
 @param meta Meta data for this client
 @param public Provides public read-only access to the resource
 @param locked Prevents this client from interaction
 @param limits Dictionary of limits to set. Keys are the names of each limit.
 @return A Client Resource
 */
- (instancetype)initWithName:(NSString *)name meta:(NSString *)meta public:(BOOL)public locked:(BOOL)locked limits:(NSDictionary*)limits;

/**
 Initialize a client resource from a plist from info request.
 
 @param plist The description property list from an info request.
 @return A Client Resource
 */
- (instancetype)initWithPList:(NSDictionary*)plist;
@end
