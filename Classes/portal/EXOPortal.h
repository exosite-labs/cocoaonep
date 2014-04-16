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
#import "EXOPortalNewUser.h"
#import "EXOPortalNewDevice.h"

extern NSString *EXOPortalErrorDomain;
#define kEXOPortalWrongType   11
#define kEXOPortalParseFailed 12

typedef void(^EXOPortalBlock)(NSError *err);
typedef void(^EXOPortalDomainsBlock)(NSArray *domains, NSError *err);
typedef void(^EXOPortalPortalsBlock)(NSArray *portals, NSError *err);
typedef void(^EXOPortalNewDeviceBlock)(NSDictionary *cikrid, NSError *err);

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

- (void)newUser:(EXOPortalNewUser*)user complete:(EXOPortalBlock)complete;
- (NSOperation*)operationForNewUser:(EXOPortalNewUser*)user complete:(EXOPortalBlock)complete;

- (void)resetPassword:(NSString*)account complete:(EXOPortalBlock)complete;
- (NSOperation*)operationForResetPassword:(NSString*)account complete:(EXOPortalBlock)complete;

- (void)newDevice:(EXOPortalNewDevice*)newDevice complete:(EXOPortalNewDeviceBlock)complete;
- (NSOperation*)operationForNewDevice:(EXOPortalNewDevice*)newDevice complete:(EXOPortalNewDeviceBlock)complete;

@end
