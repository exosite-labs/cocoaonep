//
//  EXORpc.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EXORpcActivateRequest.h"
#import "EXORpcAuthKey.h"
#import "EXORpcClientResource.h"
#import "EXORpcCloneResource.h"
#import "EXORpcCreateRequest.h"
#import "EXORpcDataportResource.h"
#import "EXORpcDataruleResource.h"
#import "EXORpcDispatchResource.h"
#import "EXORpcDeactivateRequest.h"
#import "EXORpcDropRequest.h"
#import "EXORpcFlushRequest.h"
#import "EXORpcInfoRequest.h"
#import "EXORpcListingRequest.h"
#import "EXORpcLookupRequest.h"
#import "EXORpcMapRequest.h"
#import "EXORpcReadRequest.h"
#import "EXORpcRecordRequest.h"
#import "EXORpcRevokeRequest.h"
#import "EXORpcShareRequest.h"
#import "EXORpcUnmapRequest.h"
#import "EXORpcUpdateRequest.h"
#import "EXORpcUsageRequest.h"
#import "EXORpcWriteRequest.h"

extern NSString *EXORpcDeviceErrorDomain;

typedef void(^EXORpcRPCComplete)(NSError*err);
typedef void(^EXORpcActivityChange)(BOOL active);

@interface EXORpc : NSObject
@property(nonatomic,copy,readonly) NSURL *domain;
@property(nonatomic,strong) NSOperationQueue *queue;
@property(nonatomic,copy) EXORpcActivityChange activityChange;

+ (EXORpc*)rpc;
+ (EXORpc*)rpcWithDomain:(NSURL*)domain;

- (instancetype)initWithDomain:(NSURL *)domain;

- (void)doRPCwithAuth:(EXORpcAuthKey*)auth requests:(NSArray*)calls complete:(EXORpcRPCComplete)complete;

- (NSOperation *)operationWithAuth:(EXORpcAuthKey *)auth requests:(NSArray *)calls complete:(EXORpcRPCComplete)complete;

@end
