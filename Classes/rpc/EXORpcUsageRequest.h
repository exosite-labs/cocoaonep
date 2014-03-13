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
typedef enum EXORpcUsageMetrics_e EXORpcUsageMetrics_t;

typedef void(^EXORpcUsageRequestComplete)(NSNumber *result, NSError *err);

@interface EXORpcUsageRequest : EXORpcRequest
@property(assign) EXORpcUsageMetrics_t metric;
@property(strong) NSDate *starttime;
@property(strong) NSDate *endtime;
@property(copy) EXORpcUsageRequestComplete complete;
@end
