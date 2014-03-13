//
//  EXOOnepLookupRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepRequest.h"

enum EXOOnepLookupType_e {
    EXOOnepLookupTypeAlias,
    EXOOnepLookupTypeOwner,
    EXOOnepLookupTypeShared
};
typedef enum EXOOnepLookupType_e EXOOnepLookupType_t;

typedef void(^EXOOnepLookupRequestComplete)(NSString *resut, NSError *err);

@interface EXOOnepLookupRequest : EXOOnepRequest
@property(assign) EXOOnepLookupType_t type;
@property(copy) NSString *item;
@property(copy) EXOOnepLookupRequestComplete complete;
@end
