//
//  EXOOnepUsageRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepRequest.h"

enum EXOOnepUsageMetrics_e {
    EXOOnepUsageMetricsClient,
    EXOOnepUsageMetricsDataport,
    EXOOnepUsageMetricsDatarule,
    EXOOnepUsageMetricsDispatch,
    EXOOnepUsageMetricsShare,
    EXOOnepUsageMetricsEmail,
    EXOOnepUsageMetricsHttp,
    EXOOnepUsageMetricsSms,
    EXOOnepUsageMetricsXmpp
};
typedef enum EXOOnepUsageMetrics_e EXOOnepUsageMetrics_t;

typedef void(^EXOOnepUsageRequestComplete)(NSNumber *result, NSError *err);

@interface EXOOnepUsageRequest : EXOOnepRequest
@property(assign) EXOOnepUsageMetrics_t metric;
@property(strong) NSDate *starttime;
@property(strong) NSDate *endtime;
@property(copy) EXOOnepUsageRequestComplete complete;
@end
