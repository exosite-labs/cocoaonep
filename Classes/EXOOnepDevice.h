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
#import "EXOOnepClientResource.h"
#import "EXOOnepDataportResource.h"
#import "EXOOnepDataruleResource.h"
#import "EXOOnepDispatchResource.h"
#import "EXOOnepCloneResource.h"
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
@property(nonatomic,copy,readonly) NSURL *host;
@property(nonatomic,strong) NSOperationQueue *queue;
@property(nonatomic,copy) EXOOnepAuthKey *auth;

+ (EXOOnepDevice*)device;
+ (EXOOnepDevice*)deviceWithHost:(NSURL*)host;

- (instancetype)initWithAuth:(EXOOnepAuthKey *)auth Host:(NSURL *)host;

- (void)doRPCwithRequests:(NSArray*)calls complete:(EXOOnepRPCComplete)complete;
- (void)doRPCwithAuth:(EXOOnepAuthKey*)auth requests:(NSArray*)calls complete:(EXOOnepRPCComplete)complete;

- (NSOperation *)operationWithAuth:(EXOOnepAuthKey *)auth requests:(NSArray *)calls complete:(EXOOnepRPCComplete)complete;

@end
