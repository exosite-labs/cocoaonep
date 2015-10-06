//
//  EXORpcAuthKey.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

/**
 One Platform authentication key.
 */
@interface EXORpcAuthKey : NSObject <NSCopying, NSSecureCoding>

/**
 The CIK this auth points to.
 */
@property(copy,nonatomic,readonly) NSString *cik;

/**
 An optional client RID that is a child of the CIK
 */
@property(copy,nonatomic,readonly,nullable) NSString *clientid;

/**
 An optional RID that is a child of the CIK
 */
@property(copy,nonatomic,readonly,nullable) NSString *rid;

/**
 Test if a string is formated as a CIK (or RID)
 
 @param cik The string to test
 @return YES string is formated as a CIK or RID
 @return NO string is not formated as a CIK or RID
 */
+ (BOOL)isCIK:(NSString*)cik;

/**
 Create an auth identifying the client by CIK
 
 @param cik The client CIK to authenticate with
 
 @return Authentication object to be used in RPC calls.
 */
+ (nullable EXORpcAuthKey*)authWithCIK:(NSString*)cik;

/**
 Create an auth identifying a child client by RID of the ancestor client by CIK

 @param cik The ancestor client
 @param clientid The RID of the client to reference

 @return Authentication object to be used in RPC calls.
 */
+ (nullable EXORpcAuthKey*)authWithCIK:(NSString*)cik client:(NSString*)clientid;

/**
 Create an auth identifying a child resource by RID of the ancestor client by CIK

 @param cik The ancestor client
 @param rid The RID of the resource to reference

 @return Authentication object to be used in RPC calls.
 */
+ (nullable EXORpcAuthKey*)authWithCIK:(NSString*)cik resource:(NSString*)rid;


/**
 Initialize an auth identifying the client by CIK

 @param cik The client CIK to authenticate with

 @return Authentication object to be used in RPC calls.
 */
- (nullable instancetype)initWithCIK:(NSString*)cik;

/**
 Return this auth as a plist that can be converted into JSON.
 
 @return JSON ready dictionary of values.
 */
- (NSDictionary*)plistValue;

NS_ASSUME_NONNULL_END
@end
