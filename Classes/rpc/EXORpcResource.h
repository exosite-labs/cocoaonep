//
//  EXORpcResource.h
//  CocoaOneP
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EXORpcResourceID.h"
#import "EXORpcResourceRetention.h"

/**
 Base class for One Platform Resources
 
 @warning You should never use this class directly.  Always use one of the sub-classes.
 */
@interface EXORpcResource : NSObject <NSCopying>

/**
 Meta-data for this resource
 
 This is typically a JSON encoded string.
 */
@property(copy,nonatomic,readonly) NSString *meta;

/**
 The name of this resrouce
 */
@property(copy,nonatomic,readonly) NSString *name;

/**
 The type of the resource
 */
@property(copy,nonatomic,readonly) NSString *type;

/**
 Weither this resource can be seen by all One Platform users or not
 */
@property(assign,nonatomic,readonly) BOOL public;

/**
 Create a resource
 
 @param name The name of this resrouce
 @param meta Meta-data for this resource
 @param public Publicly visible or not
 @return The resource
 */
+ (EXORpcResource*)resourceWithName:(NSString*)name meta:(NSString*)meta public:(BOOL)public;

/**
 Create a resource

 @param name The name of this resrouce
 @param meta Meta-data for this resource
 @return The resource
 */
+ (EXORpcResource*)resourceWithName:(NSString*)name meta:(NSString*)meta;

/**
 Initialize a resource

 @param name The name of this resrouce
 @param meta Meta-data for this resource
 @param public Publicly visible or not
 @return The resource
 */
- (instancetype)initWithName:(NSString*)name meta:(NSString*)meta public:(BOOL)public;

/**
 Initialize a resource

 @param name The name of this resrouce
 @param meta Meta-data for this resource
 @return The resource
 */
- (instancetype)initWithName:(NSString*)name meta:(NSString*)meta;

/**
 Return the resource as a JSON ready plist.
 */
- (id)plistValue;

@end
