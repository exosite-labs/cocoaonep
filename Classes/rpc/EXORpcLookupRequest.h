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

@interface EXORpcLookupRequest : EXORpcRequest <NSCopying>
@property(assign,nonatomic,readonly) EXORpcLookupType_t type;
@property(copy,nonatomic,readonly) NSString *item;
@property(copy,nonatomic,readonly) EXORpcLookupRequestComplete complete;

+ (EXORpcLookupRequest*)lookupWithType:(EXORpcLookupType_t)type item:(NSString*)item complete:(EXORpcLookupRequestComplete)complete;
- (instancetype)initWithType:(EXORpcLookupType_t)type item:(NSString*)item complete:(EXORpcLookupRequestComplete)complete;
@end
