//
//  EXOOnepInfoRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepRequest.h"

enum EXOOnepInfoRequestTypes_e {
    EXOOnepInfoRequestTypeAliases = 1 << 0,
    EXOOnepInfoRequestTypeBasic = 1 << 1,
    EXOOnepInfoRequestTypeComments = 1 << 2,
    EXOOnepInfoRequestTypeCounts = 1 << 3,
    EXOOnepInfoRequestTypeDescription = 1 << 4,
    EXOOnepInfoRequestTypeKey = 1 << 5,
    EXOOnepInfoRequestTypeShares = 1 << 6,
    EXOOnepInfoRequestTypeTagged = 1 << 7,
    EXOOnepInfoRequestTypeTags = 1 << 8,
    EXOOnepInfoRequestTypeUsage = 1 << 9,
    EXOOnepInfoRequestTypeAll = 0,
    };
typedef enum EXOOnepInfoRequestTypes_e EXOOnepInfoRequestTypes_t;

typedef void(^EXOOnepInfoRequestComplete)(NSDictionary *res, NSError *err);

@interface EXOOnepInfoRequest : EXOOnepRequest <NSCopying>
@property(nonatomic,assign,readonly) EXOOnepInfoRequestTypes_t types;
@property(nonatomic,copy,readonly) EXOOnepInfoRequestComplete complete;

+ (EXOOnepInfoRequest*)infoByRID:(EXOOnepResourceID *)rid types:(EXOOnepInfoRequestTypes_t)types complete:(EXOOnepInfoRequestComplete)complete;
- (instancetype)initWithRID:(EXOOnepResourceID *)rid types:(EXOOnepInfoRequestTypes_t)types complete:(EXOOnepInfoRequestComplete)complete;

@end
