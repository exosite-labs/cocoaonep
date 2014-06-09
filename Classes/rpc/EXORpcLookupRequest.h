//
//  EXORpcLookupRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcRequest.h"

/**
 Lookup types
 */
enum EXORpcLookupType_e {
    EXORpcLookupTypeAlias,
    EXORpcLookupTypeOwner,
    EXORpcLookupTypeShared
};
typedef enum EXORpcLookupType_e EXORpcLookupType_t;

/**
 Callback for the results of a lookup
 @param result The RID that was looked up
 @param error nil on Success, otherwise the error
 */
typedef void(^EXORpcLookupRequestComplete)(NSString *result, NSError *error);

/**
 Look up a Resource ID by alias, owned Resource ID, or share activation code.
 */
@interface EXORpcLookupRequest : EXORpcRequest <NSCopying>
@property(assign,nonatomic,readonly) EXORpcLookupType_t type;  /// What type of thing to lookup
@property(copy,nonatomic,readonly) NSString *item;  /// The key to lookup
@property(copy,nonatomic,readonly) EXORpcLookupRequestComplete complete;

/**
 Create a lookup request
 
 @param type The type of lookup to do
 @param item The key of the thing to lookup
 @param complete The callback to collect the results
 @return The Lookup Request
 */
+ (EXORpcLookupRequest*)lookupWithType:(EXORpcLookupType_t)type item:(NSString*)item complete:(EXORpcLookupRequestComplete)complete;

/**
 Initialize a lookup request

 @param type The type of lookup to do
 @param item The key of the thing to lookup
 @param complete The callback to collect the results
 @return The Lookup Request
 */
- (instancetype)initWithType:(EXORpcLookupType_t)type item:(NSString*)item complete:(EXORpcLookupRequestComplete)complete;
@end
