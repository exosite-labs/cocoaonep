//
//  EXORpcLookupRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcRequest.h"

enum EXORpcLookupType_e {
    EXORpcLookupTypeAlias,
    EXORpcLookupTypeOwner,
    EXORpcLookupTypeShared
};
typedef enum EXORpcLookupType_e EXORpcLookupType_t;

typedef void(^EXORpcLookupRequestComplete)(NSString *resut, NSError *err);

@interface EXORpcLookupRequest : EXORpcRequest
@property(assign) EXORpcLookupType_t type;
@property(copy) NSString *item;
@property(copy) EXORpcLookupRequestComplete complete;
@end
