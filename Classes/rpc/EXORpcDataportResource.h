//
//  EXORpcDataportResource.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcResource.h"
#import "EXORpcPreprocessOperation.h"

enum EXORpcDataportFormat_e {
    EXORpcDataportFormatString = 0, /// Store data as strings
    EXORpcDataportFormatFloat,      /// Store data as floats
    EXORpcDataportFormatInteger,    /// Store data as integers

    EXORpcDataportFormatUnchanged,  /// When creating an update request, and you do not want to change the format type.
};
/**
 The format types that data can be stored in.
 */
typedef enum EXORpcDataportFormat_e EXORpcDataportFormat_t;

/**
 A dataport resource
 */
@interface EXORpcDataportResource : EXORpcResource

/**
 The format that the datarule stores its data.
 */
@property(assign,nonatomic,readonly) EXORpcDataportFormat_t format;

/**
 A list of operations to be preformed on the incoming data.
 */
@property(strong,nonatomic,readonly) NSArray *preprocess;

/**
 The RID to which this resource is subscribed

 This resource will receive a publication whenever a value is written to the specified RID.
 Then it will apply the rule to the new value.
 
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
+ (EXORpcDataportResource*)dataportWithName:(NSString *)name format:(EXORpcDataportFormat_t)format;

/**
 Create a dataport resource
 
 @param name The name of this dataport
 @param format The format that the dataport stores its data
 @param retention How much to history of values to keep
 
 @return The dataport resource
 */
+ (EXORpcDataportResource*)dataportWithName:(NSString *)name format:(EXORpcDataportFormat_t)format retention:(EXORpcResourceRetention*)retention;

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
+ (EXORpcDataportResource*)dataportWithName:(NSString *)name meta:(NSString *)meta public:(BOOL)public format:(EXORpcDataportFormat_t)format preprocess:(NSArray*)preprocess subscribe:(EXORpcResourceID*)subscribe retention:(EXORpcResourceRetention*)retention;

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
- (instancetype)initWithName:(NSString *)name meta:(NSString *)meta public:(BOOL)public format:(EXORpcDataportFormat_t)format preprocess:(NSArray*)preprocess subscribe:(EXORpcResourceID*)subscribe retention:(EXORpcResourceRetention*)retention;

/**
 Initialize a dataport resource from a plist from info request.

 @param plist The description property list from an info request.
 @return A Dataport Resource
 */
- (instancetype)initWithPList:(NSDictionary*)plist;

@end
