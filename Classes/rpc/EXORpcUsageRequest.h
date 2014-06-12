//
//  EXORpcUsageRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcRequest.h"

enum EXORpcUsageMetrics_e {
    EXORpcUsageMetricsClient,
    EXORpcUsageMetricsDataport,
    EXORpcUsageMetricsDatarule,
    EXORpcUsageMetricsDispatch,
    EXORpcUsageMetricsShare,
    EXORpcUsageMetricsEmail,
    EXORpcUsageMetricsHttp,
    EXORpcUsageMetricsSms,
    EXORpcUsageMetricsXmpp
};
/**
 The metrics that can be measured.
 */
typedef enum EXORpcUsageMetrics_e EXORpcUsageMetrics_t;

/**
 Callback with the metric's value
 
 @param result The value of the metric requested
 @param error nil on success, otherwise the reason for failure
 */
typedef void(^EXORpcUsageRequestComplete)(NSNumber *result, NSError *error);

/**
 Request the metric usage for client and its subhierarchy
 */
@interface EXORpcUsageRequest : EXORpcRequest <NSCopying>

/**
 Which metric to query
 */
@property(assign,nonatomic,readonly) EXORpcUsageMetrics_t metric;

/**
 The start for a window for the metric to measure
 */
@property(copy,nonatomic,readonly) NSDate *starttime;

/**
 The end for a window for the metric to measure
 */
@property(copy,nonatomic,readonly) NSDate *endtime;

@property(copy,nonatomic,readonly) EXORpcUsageRequestComplete complete;

/**
 Create a usage request

 @param rid The resource to get usage info for
 @param metric Which metric to return
 @param starttime Define a start for a window for the metric to measure
 @param endtime Define an end for a window for the metric to measure
 @param complete The callback when complete
 @return The usage request
 */
+ (EXORpcUsageRequest*)usageWithRID:(EXORpcResourceID *)rid metric:(EXORpcUsageMetrics_t)metric start:(NSDate*)starttime end:(NSDate*)endtime complete:(EXORpcUsageRequestComplete)complete;

/**
 Create a usage request

 @param rid The resource to get usage info for
 @param metric Which metric to return
 @param complete The callback when complete
 @return The usage request
 */
+ (EXORpcUsageRequest*)usageWithRID:(EXORpcResourceID *)rid metric:(EXORpcUsageMetrics_t)metric complete:(EXORpcUsageRequestComplete)complete;


/**
 Initialize a usage request

 @param rid The resource to get usage info for
 @param metric Which metric to return
 @param starttime Define a start for a window for the metric to measure
 @param endtime Define an end for a window for the metric to measure
 @param complete The callback when complete
 @return The usage request
 */
- (instancetype)initWithRID:(EXORpcResourceID *)rid metric:(EXORpcUsageMetrics_t)metric start:(NSDate*)starttime end:(NSDate*)endtime complete:(EXORpcUsageRequestComplete)complete;

@end
