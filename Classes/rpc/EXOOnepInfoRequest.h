//
//  EXORpcInfoRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcRequest.h"

enum EXORpcInfoRequestTypes_e {
    EXORpcInfoRequestTypeAliases = 1 << 0,
    EXORpcInfoRequestTypeBasic = 1 << 1,
    EXORpcInfoRequestTypeComments = 1 << 2,
    EXORpcInfoRequestTypeCounts = 1 << 3,
    EXORpcInfoRequestTypeDescription = 1 << 4,
    EXORpcInfoRequestTypeKey = 1 << 5,
    EXORpcInfoRequestTypeShares = 1 << 6,
    EXORpcInfoRequestTypeTagged = 1 << 7,
    EXORpcInfoRequestTypeTags = 1 << 8,
    EXORpcInfoRequestTypeUsage = 1 << 9,
    EXORpcInfoRequestTypeAll = 0,
    };
typedef enum EXORpcInfoRequestTypes_e EXORpcInfoRequestTypes_t;

typedef void(^EXORpcInfoRequestComplete)(NSDictionary *res, NSError *err);

@interface EXORpcInfoRequest : EXORpcRequest <NSCopying>
@property(nonatomic,assign,readonly) EXORpcInfoRequestTypes_t types;
@property(nonatomic,copy,readonly) EXORpcInfoRequestComplete complete;

+ (EXORpcInfoRequest*)infoByRID:(EXORpcResourceID *)rid types:(EXORpcInfoRequestTypes_t)types complete:(EXORpcInfoRequestComplete)complete;
- (instancetype)initWithRID:(EXORpcResourceID *)rid types:(EXORpcInfoRequestTypes_t)types complete:(EXORpcInfoRequestComplete)complete;

@end
