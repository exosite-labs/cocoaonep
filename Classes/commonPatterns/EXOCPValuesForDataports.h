//
//  EXOCPValuesForDataports.h
//
//  Created by Michael Conrad Tadpol Tilstra on 4/15/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EXORpc.h>


typedef void(^EXOCPValuesForDataportsComplete)(NSArray *results);

/**
 \brief Get a list of values for a list of dataports

 This strives to use the minimum number of network connections to get all of the values.
 */
@interface EXOCPValuesForDataports : NSOperation

/**
 The RPC object to use for contacting 1P.
 */
@property (strong,nonatomic) EXORpc *onep;

/**
 An Array of arrays.  The inner array only has two items: an auth and a rid.
 So: @[ @[ EXORpcAuthKey, EXORpcResourceID ], ...]
 */
@property (strong,nonatomic) NSArray *dataports;

/**
 \brief Template to use for the read requests.
 
 This allows for setting different time ranges and limits and such.
 */
@property (strong,nonatomic) EXORpcReadRequest *readTemplate;

/**
 */
@property (copy,nonatomic) EXOCPValuesForDataportsComplete complete;
@end
