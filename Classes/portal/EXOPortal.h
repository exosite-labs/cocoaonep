//
//  EXOPortal.h
//
//  Created by Michael Conrad Tadpol Tilstra on 3/13/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import "EXOPortalAuth.h"
#import "EXOPortalDomain.h"
#import "EXOPortalPortal.h"

typedef void(^EXOPortalDomainsBlock)(NSArray *domains, NSError *err);
typedef void(^EXOPortalPortalsBlock)(NSArray *domains, NSError *err);

@interface EXOPortal : NSObject
@property(copy,nonatomic,readonly) NSURL *domain;
@property(copy,nonatomic,readonly) EXOPortalAuth *auth;

+ (EXOPortal*)portalWithAuth:(EXOPortalAuth*)auth;
+ (EXOPortal*)portalWithAuth:(EXOPortalAuth*)auth domain:(NSURL*)domain;

- (instancetype)initWithAuth:(EXOPortalAuth*)auth domain:(NSURL*)domain;


- (void)domains:(EXOPortalDomainsBlock)complete;
- (NSOperation*)operationForDomains:(EXOPortalDomainsBlock)complete;

- (void)portals:(EXOPortalPortalsBlock)complete;
- (NSOperation*)operationForPortals:(EXOPortalPortalsBlock)complete;

// TODO: New Account

// TODO: Reset Password

// TODO: Create New Device

@end
