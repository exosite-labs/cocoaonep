//
//  EXORpcUsageRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcUsageRequest.h"

@implementation EXORpcUsageRequest

- (void)doResult:(NSDictionary *)result error:(NSError *)error
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
        args[2] = @(1);
    }
    if (self.endtime) {
        args[3] = @([self.endtime timeIntervalSince1970]);
    } else {
        args[3] = @([[NSDate dateWithTimeIntervalSinceNow:10.0] timeIntervalSince1970]);
    }
    return @{ @"procedure": @"usage", @"arguments": args};
}
@end
