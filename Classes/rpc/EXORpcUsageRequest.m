//
//  EXORpcUsageRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcUsageRequest.h"

@implementation EXORpcUsageRequest

+ (EXORpcUsageRequest *)usageWithRID:(EXORpcResourceID *)rid metric:(EXORpcUsageMetrics_t)metric start:(NSDate *)starttime end:(NSDate *)endtime complete:(EXORpcUsageRequestComplete)complete
{
    return [[EXORpcUsageRequest alloc] initWithRID:rid metric:metric start:starttime end:endtime complete:complete];
}

+ (EXORpcUsageRequest *)usageWithRID:(EXORpcResourceID *)rid metric:(EXORpcUsageMetrics_t)metric complete:(EXORpcUsageRequestComplete)complete
{
    return [[EXORpcUsageRequest alloc] initWithRID:rid metric:metric start:nil end:nil complete:complete];
}

- (instancetype)initWithRID:(EXORpcResourceID *)rid metric:(EXORpcUsageMetrics_t)metric start:(NSDate *)starttime end:(NSDate *)endtime complete:(EXORpcUsageRequestComplete)complete
{
    if (self = [super initWithRID:rid]) {
        _metric = metric;
        _starttime = [starttime copy];
        _endtime = [endtime copy];
        _complete = [complete copy];
    }
    return self;
}

- (id)init
{
    return nil;
}

- (void)doResult:(NSDictionary *)result
{
    if (self.complete) {
        NSError *err = [self errorFromStatus:result];
        if (err) {
            self.complete(nil, err);
        } else {
            self.complete(result[@"result"], nil);
        }
    }
}

- (NSDictionary *)plistValue
{
    NSMutableArray *args = [NSMutableArray arrayWithCapacity:4];
    args[0] = [self.rid plistValue];
    switch (self.metric) {
        case EXORpcUsageMetricsClient:
            args[1] = @"client";
            break;
        case EXORpcUsageMetricsDataport:
            args[1] = @"dataport";
            break;
        case EXORpcUsageMetricsDatarule:
            args[1] = @"datarule";
            break;
        case EXORpcUsageMetricsDispatch:
            args[1] = @"dispatch";
            break;
        case EXORpcUsageMetricsEmail:
            args[1] = @"email";
            break;
        case EXORpcUsageMetricsHttp:
            args[1] = @"http";
            break;
        case EXORpcUsageMetricsShare:
            args[1] = @"share";
            break;
        case EXORpcUsageMetricsSms:
            args[1] = @"sms";
            break;
        case EXORpcUsageMetricsXmpp:
            args[1] = @"xmpp";
            break;

        default:
            break;
    }
    if (self.starttime) {
        args[2] = @([self.starttime timeIntervalSince1970]);
    } else {
        args[2] = @(0);
    }
    if (self.endtime) {
        args[3] = @([self.endtime timeIntervalSince1970]);
    } else {
        args[3] = @([[NSDate dateWithTimeIntervalSinceNow:10.0] timeIntervalSince1970]);
    }
    return @{ @"procedure": @"usage", @"arguments": args};
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    return  [self.rid isEqual:[object rid]] &&
    (self.metric == [object metric]) &&
    ((self.starttime == nil && [object starttime] == nil) || [self.starttime isEqualToDate:[object starttime]]) &&
    ((self.endtime == nil && [object endtime] == nil) || [self.endtime isEqualToDate:[object endtime]]);
}

- (NSUInteger)hash
{
    return self.rid.hash ^ self.metric ^ self.starttime.hash ^ self.endtime.hash;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

@end
