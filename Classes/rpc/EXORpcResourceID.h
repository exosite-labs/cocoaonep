//
//  EXORpcResourceID.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Resource Identifier
 */
@interface EXORpcResourceID : NSObject <NSCopying>

/**
 Directly identify a resource by its RID string.
 
 The resource must be in the calling client's subhierarchy.

 @param rid The 40 character resource identifier
 @return The resource identifier
 */
+ (EXORpcResourceID*)resourceIDByRID:(NSString*)rid;

/**
 Identify an immediate child of the calling client by alias.

 @param alias The alias to look up.
 @return The resource identifier
 */
+ (EXORpcResourceID*)resourceIDByAlias:(NSString*)alias;

/**
 Identify the calling client itself.
 @return The resource identifier
 */
+ (EXORpcResourceID*)resourceIDAsSelf;

/**
 Directly identify a resource by its RID string.

 The resource must be in the calling client's subhierarchy.

 @param rid The 40 character resource identifier
 @return The resource identifier
 */
- (instancetype)initWithRID:(NSString*)rid;

/**
 Identify an immediate child of the calling client by alias.

 @param alias The alias to look up.
 @return The resource identifier
 */
- (instancetype)initWithAlias:(NSString*)alias;

/**
 Identify the calling client itself.
 @return The resource identifier
 */
- (instancetype)init;

/**
 Return this auth as a plist that can be converted into JSON.

 @return JSON ready dictionary of values.
 */
- (id)plistValue;
@end
