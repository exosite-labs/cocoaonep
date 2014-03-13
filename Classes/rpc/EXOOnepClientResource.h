//
//  EXOOnepCreateClientRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepResource.h"

@interface EXOOnepClientResource : EXOOnepResource
@property(assign) BOOL locked;

@property(copy) NSNumber *limitClient;
@property(copy) NSNumber *limitDataport;
@property(copy) NSNumber *limitDatarule;
@property(copy) NSNumber *limitDisk;
@property(copy) NSNumber *limitDispatch;
@property(copy) NSNumber *limitIO;
@property(copy) NSNumber *limitEmail;
@property(copy) NSNumber *limitEmailBucket;
@property(copy) NSNumber *limitHttp;
@property(copy) NSNumber *limitHttpBucket;
@property(copy) NSNumber *limitShare;
@property(copy) NSNumber *limitSms;
@property(copy) NSNumber *limitSmsBucket;
@property(copy) NSNumber *limitXmpp;
@property(copy) NSNumber *limitXmppBucket;

@end
