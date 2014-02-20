//
//  EXOOnepUsageRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepUsageRequest.h"

@implementation EXOOnepUsageRequest

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

- (NSDictionary *)asCall
{
    NSMutableArray *args = [NSMutableArray arrayWithCapacity:4];
    args[0] = [self.rid asCall];
    switch (self.metric) {
        case EXOOnepUsageMetricsClient:
            args[1] = @"client";
            break;
        case EXOOnepUsageMetricsDataport:
            args[1] = @"dataport";
            break;
        case EXOOnepUsageMetricsDatarule:
            args[1] = @"datarule";
            break;
        case EXOOnepUsageMetricsDispatch:
            args[1] = @"dispatch";
            break;
        case EXOOnepUsageMetricsEmail:
            args[1] = @"email";
            break;
        case EXOOnepUsageMetricsHttp:
            args[1] = @"http";
            break;
        case EXOOnepUsageMetricsShare:
            args[1] = @"share";
            break;
        case EXOOnepUsageMetricsSms:
            args[1] = @"sms";
            break;
        case EXOOnepUsageMetricsXmpp:
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
