//
//  EXOOnepDevice.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EXOOnepAuthKey.h"
#import "EXOOnepReadRequest.h"
#import "EXOOnepWriteRequest.h"
#import "EXOOnepActivateRequest.h"
#import "EXOOnepCreateClientRequest.h"
#import "EXOOnepCreateDataportRequest.h"
#import "EXOOnepCreateDataruleRequest.h"
#import "EXOOnepCreateDispatchRequest.h"
#import "EXOOnepCreateCloneRequest.h"
#import "EXOOnepDeactivateRequest.h"
#import "EXOOnepDropRequest.h"
#import "EXOOnepFlushRequest.h"
#import "EXOOnepInfoRequest.h"
#import "EXOOnepListingRequest.h"
#import "EXOOnepLookupRequest.h"
#import "EXOOnepMapRequest.h"
#import "EXOOnepRecordRequest.h"
#import "EXOOnepRevokeRequest.h"
#import "EXOOnepShareRequest.h"
#import "EXOOnepUnmapRequest.h"
#import "EXOOnepUpdateRequest.h"
#import "EXOOnepUsageRequest.h"

extern NSString *EXOOnepDeviceErrorDomain;

typedef void(^EXOOnepRPCComplete)(NSError*err);

@interface EXOOnepDevice : NSObject
@property(nonatomic,copy,readonly) EXOOnepAuthKey *auth;
@property(nonatomic,copy,readonly) NSURL *host;
// TODO: Add work queue option. (?)

// TODO: (maybe) Write some mid/high level methods. (create dataport with alias for example?)

+ (EXOOnepDevice *)deviceWithAuth:(EXOOnepAuthKey *)auth;
+ (EXOOnepDevice*)deviceWithAuth:(EXOOnepAuthKey*)auth Host:(NSURL*)host;

- (instancetype)initWithAuth:(EXOOnepAuthKey*)auth Host:(NSURL*)host;

// The base of it all.
- (void)doRPCwithRequests:(NSArray*)calls complete:(EXOOnepRPCComplete)complete;

@end
