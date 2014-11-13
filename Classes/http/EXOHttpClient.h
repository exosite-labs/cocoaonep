//
//  EXOHttpClient.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Callback for a completed write request
 
 @param error If not nil, the error that prevented the request from completing.
 */
typedef void(^EXOHttpClientWriteComplete)(NSError *error);

/**
 Callback for a completed read request

 @param results The values read; aliases are the keys.
 @param error If not nil, the error that prevented the request from completing.
*/
typedef void(^EXOHttpClientReadComplete)(NSDictionary *results, NSError *error);

/**
 Interface for doing simple read or write action to One Platform.
 */
@interface EXOHttpClient : NSObject <NSCopying>

/**
 The CIK of the client to read or write dataport from.
 */
@property(nonatomic,copy,readonly) NSString *CIK;

/**
 The domain that this CIK lives.
 */
@property(nonatomic,copy,readonly) NSURL *host;

/**
 Initial with a CIK and the default host
 
 @param CIK The 40 character CIK of the Client to interact with
 @return EXOHttpClient
 */
- (instancetype)initWithCIK:(NSString*)CIK;

/**
 Initial with a CIK and host

 @param CIK The 40 character CIK of the Client to interact with
 @param host The host to send requests to. Setting to nil will use the default host.
 @return EXOHttpClient
 */
- (instancetype)initWithCIK:(NSString*)CIK host:(NSURL*)host;

/**
 Write data to aliases on the CIK

 @param data Dictionary of aliases and values to write to.
 @param complete Callback for when the write is finished
 */
- (void)writeAliases:(NSDictionary*)data complete:(EXOHttpClientWriteComplete)complete;

/**
 Read data from a CIK
 
 @param aliases An Array of NSString of each alias on the CIK to read the current value of.
 @param complete The callback called with the results of the request.
 */
- (void)readAliases:(NSArray*)aliases complete:(EXOHttpClientReadComplete)complete;

/**
 Wait for data from a CIK

 @param aliases An Array of NSString of each alias on the CIK to read the current value of.
 @param complete The callback called with the results of the request.
 */
- (void)waitAliases:(NSArray*)aliases complete:(EXOHttpClientReadComplete)complete;

/**
 Wait for data from a CIK
 
 @param aliases An Array of NSString of each alias on the CIK to read the current value of.
 @param timeout How long to wait for new data (1 to 300000 milliseconds)
 @param since When to start wait for data (defaults to now if nil)
 @param complete The callback called with the results of the request.
 */
- (void)waitAliases:(NSArray*)aliases timeout:(NSNumber*)timeout since:(NSDate*)since complete:(EXOHttpClientReadComplete)complete;

@end
