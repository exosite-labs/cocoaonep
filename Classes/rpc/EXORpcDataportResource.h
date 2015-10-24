//
//  EXORpcDataportResource.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014-2015 Exosite. All rights reserved.
//

#import "EXORpcResource.h"
#import "EXORpcPreprocessOperation.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The format types that data can be stored in.
 */
typedef NS_ENUM(NSUInteger,EXORpcDataportFormat) {
    EXORpcDataportFormatString = 0, /// Store data as strings
    EXORpcDataportFormatFloat,      /// Store data as floats
    EXORpcDataportFormatInteger,    /// Store data as integers

    EXORpcDataportFormatUnchanged,  /// When creating an update request, and you do not want to change the format type.
};

/**
 A dataport resource
 */
@interface EXORpcDataportResource : EXORpcResource

/**
 The format that the datarule stores its data.
 */
@property(assign,nonatomic,readonly) EXORpcDataportFormat format;

/**
 A list of operations to be preformed on the incoming data.
 */
@property(strong,nonatomic,readonly) NSArray<EXORpcPreprocessOperation*> *preprocess;

/**
 The RID to which this resource is subscribed

 This resource will receive a publication whenever a value is written to the specified RID.

 nil if not subscribed.
 */
@property(strong,nonatomic,readonly) EXORpcResourceID *subscribe;

/**
 How much to history of values to keep
 */
@property(copy,nonatomic,readonly) EXORpcResourceRetention *retention;

/**
 Create a dataport resource
 
 @param name The name of this dataport
 @param format The format that the dataport stores its data
 
 @return The dataport resource
 */
+ (nullable EXORpcDataportResource*)dataportWithName:(NSString *)name format:(EXORpcDataportFormat)format;

/**
 Create a dataport resource
 
 @param name The name of this dataport
 @param format The format that the dataport stores its data
 @param retention How much to history of values to keep
 
 @return The dataport resource
 */
+ (nullable EXORpcDataportResource*)dataportWithName:(NSString *)name format:(EXORpcDataportFormat)format retention:(EXORpcResourceRetention*)retention;

/**
 Create a dataport resource
 
 @param name The name of this dataport
 @param meta General purpose metadata
 @param public If true, provide public read-only access to the resource
 @param format The format that the dataport stores its data
 @param preprocess A list of operations to be preformed on the incoming data
 @param subscribe The RID to which this resource is subscribed.
 @param retention How much to history of values to keep
 
 @return The dataport resource
 */
+ (nullable EXORpcDataportResource*)dataportWithName:(NSString *)name meta:(nullable NSString *)meta public:(BOOL)public format:(EXORpcDataportFormat)format preprocess:(nullable NSArray<EXORpcPreprocessOperation*>*)preprocess subscribe:(nullable EXORpcResourceID*)subscribe retention:(nullable EXORpcResourceRetention*)retention;

/**
 Initialize a dataport resource

 @param name The name of this dataport
 @param format The format that the dataport stores its data

 @return The dataport resource
 */
- (instancetype)initWithName:(NSString *)name format:(EXORpcDataportFormat)format;

/**
 Initialize a dataport resource
 
 @param name The name of this dataport
 @param meta General purpose metadata
 @param public If true, provide public read-only access to the resource
 @param format The format that the dataport stores its data
 @param preprocess A list of operations to be preformed on the incoming data
 @param subscribe The RID to which this resource is subscribed.
 @param retention How much to history of values to keep
 
 @return The dataport resource
 */
- (instancetype)initWithName:(NSString *)name meta:(nullable NSString *)meta public:(BOOL)public format:(EXORpcDataportFormat)format preprocess:(nullable NSArray<EXORpcPreprocessOperation*>*)preprocess subscribe:(nullable EXORpcResourceID*)subscribe retention:(nullable EXORpcResourceRetention*)retention NS_DESIGNATED_INITIALIZER;

/**
 Initialize a dataport resource from a plist from info request.

 @param plist The description property list from an info request.
 @return A Dataport Resource
 */
- (instancetype)initWithPList:(NSDictionary*)plist;

NS_ASSUME_NONNULL_END

@end
