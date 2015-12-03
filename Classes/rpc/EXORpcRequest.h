//
//  EXORpcRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EXORpcResourceID.h"
NS_ASSUME_NONNULL_BEGIN

/**
 Error Domain for NSError from a request
 */
extern NSString *kEXORpcErrorDomain;

#define kEXORpcErrorTypeUnknown    -1
#define kEXORpcErrorTypeOk         0
#define kEXORpcErrorTypeInvalid    1
#define kEXORpcErrorTypeNoAuth     2
#define kEXORpcErrorTypeExpired    3
#define kEXORpcErrorTypeRestricted 4

/**
 Callback for a request that does not return data
 
 @param error nil on success, otherwise error indicating failure
 */
typedef void(^EXORpcRequestComplete)(NSError * __nullable error);

/**
 Base of all requests to the platform.
 
 This should never be used directly; only use the sub-classes.
 */
@interface EXORpcRequest : NSObject
// TODO: Make this and all its children immutable objects.

@property(nonatomic,copy) EXORpcResourceID *rid; /// Resource ID for request to act on

/**
 Initialize a request with a resource ID
 @param rid The resource ID
 @return A request
 */
- (instancetype)initWithRID:(EXORpcResourceID*)rid;

/**
 Initialize a request with a resoruce ID of self.
 @return A request
 */
- (id)init;

/**
 Convert One Platform errors into local error codes
 @param status The One Platform status code
 @return The error code
 */
- (NSInteger)codeFromStatus:(nullable NSString*)status;

/**
 Parse the status result from One Platform
 
 @param status The status details returned from a One Platform Request
 @return The status as an NSError (or nil if no error)
 */
- (NSError*)errorFromStatus:(nullable NSDictionary*)status;

/**
 Result handler for this request.
 
 Sub-clases *must* impolement this function.
 
 Raises an exception if not implemented by sub-class.
 */
- (void)doResult:(NSDictionary*)result;

/**
 Get the request as a dictionary that is JSON clean

 @return A dictionary representation of the request.
 */
- (NSDictionary*)plistValue;

NS_ASSUME_NONNULL_END
@end
