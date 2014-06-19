//
//  EXORpcCreateDataruleRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcResource.h"
#import "EXORpcDataportResource.h"
#import "EXORpcDataruleSimple.h"
#import "EXORpcDataruleTimeout.h"
#import "EXORpcDataruleInterval.h"
#import "EXORpcDataruleDuration.h"
#import "EXORpcDataruleCount.h"
#import "EXORpcDataruleScript.h"

/**
 A Daterule Resource
 */
@interface EXORpcDataruleResource : EXORpcResource

/**
 The format that the datarule stores its data.
 
 This must be the Integer type for all rules except script, which is a string.
 */
@property(assign,nonatomic,readonly) EXORpcDataportFormat_t format;

/**
 The rules for the datarule.
 */
@property(copy,nonatomic,readonly) EXORpcDatarule *rule;

/**
 How much to history of values to keep
 */
@property(copy,nonatomic,readonly) EXORpcResourceRetention *retention;

/**
 The RID to which this resource is subscribed
 
 This resource will receive a publication whenever a value is written to the specified RID.
 Then it will apply the rule to the new value.
 */
@property(copy,nonatomic,readonly) EXORpcResourceID *subscribe;

/**
 A list of operations to be preformed on the incoming data.
 */
@property(strong,nonatomic,readonly) NSArray *preprocess;

/**
 Create a datarule
 
 @param name The name of this rule
 @param rule The rule
 @param subscribe The RID to which this resource is subscribed.
 @return The datarule
 */
+ (EXORpcDataruleResource*)dataruleWithName:(NSString*)name rule:(EXORpcDatarule*)rule subscribe:(EXORpcResourceID*)subscribe;

/**
 Create a script rule
 
 While scripts are technically datarules, they don't work like other data rules.  This is esspecially clear in that they ignore all the other parameters that the other datarules use.

 @param name The name of this rule
 @param script The lua script to upload
 @return The script datarule
 */
+ (EXORpcDataruleResource*)dataruleWithName:(NSString*)name script:(NSString*)script;

/**
 Initialize a datarule
 
 Unless you have a real need, use +dataruleWithName:rule:subscribe: instead.

 @param name The name of this rule
 @param meta General purpose metadata
 @param public If true, provide public read-only access to the resource
 @param format The format that the datarule stores its data
 @param retention How much to history of values to keep
 @param rule The rule
 @param subscribe The RID to which this resource is subscribed.
 @param preprocess A list of operations to be preformed on the incoming data
 @return The datarule
 */
- (instancetype)initWithName:(NSString *)name meta:(NSString *)meta public:(BOOL)public format:(EXORpcDataportFormat_t)format retention:(EXORpcResourceRetention*)retention rule:(EXORpcDatarule*)rule subscribe:(EXORpcResourceID*)subscribe preprocess:(NSArray*)preprocess;

@end
