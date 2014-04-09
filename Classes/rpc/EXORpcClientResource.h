//
//  EXORpcCreateClientRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcResource.h"

@interface EXORpcClientResource : EXORpcResource
@property(assign,nonatomic,readonly) BOOL locked;

@property(copy,nonatomic,readonly) NSNumber *limitClient;
@property(copy,nonatomic,readonly) NSNumber *limitDataport;
@property(copy,nonatomic,readonly) NSNumber *limitDatarule;
@property(copy,nonatomic,readonly) NSNumber *limitDisk;
@property(copy,nonatomic,readonly) NSNumber *limitDispatch;
@property(copy,nonatomic,readonly) NSNumber *limitIO;
@property(copy,nonatomic,readonly) NSNumber *limitEmail;
@property(copy,nonatomic,readonly) NSNumber *limitEmailBucket;
@property(copy,nonatomic,readonly) NSNumber *limitHttp;
@property(copy,nonatomic,readonly) NSNumber *limitHttpBucket;
@property(copy,nonatomic,readonly) NSNumber *limitShare;
@property(copy,nonatomic,readonly) NSNumber *limitSms;
@property(copy,nonatomic,readonly) NSNumber *limitSmsBucket;
@property(copy,nonatomic,readonly) NSNumber *limitXmpp;
@property(copy,nonatomic,readonly) NSNumber *limitXmppBucket;

+ (EXORpcClientResource*)resourceWithName:(NSString *)name meta:(NSString *)meta public:(BOOL)public locked:(BOOL)locked limits:(NSDictionary*)limits;
+ (EXORpcClientResource*)resourceWithName:(NSString *)name meta:(NSString *)meta;

- (instancetype)initWithName:(NSString *)name meta:(NSString *)meta public:(BOOL)public locked:(BOOL)locked limits:(NSDictionary*)limits;

@end
