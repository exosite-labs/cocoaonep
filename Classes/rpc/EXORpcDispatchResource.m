//
//  EXORpcCreateDispatchRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcDispatchResource.h"

@implementation EXORpcDispatchResource

- (NSArray *)plistValue
{
    NSMutableDictionary *args = [NSMutableDictionary dictionaryWithCapacity:13];
    args[@"locked"] = @(self.locked);
    if (self.message) {
        args[@"message"] = self.message;
    }
    if (self.meta) {
        args[@"meta"] = self.meta;
    }
    switch (self.method) {
        default:
        case EXORpcDispactMethodEmail:
            args[@"method"] = @"email";
            break;
        case EXORpcDispactMethodHttpGet:
            args[@"method"] = @"http_get";
            break;
        case EXORpcDispactMethodHttpPost:
            args[@"method"] = @"http_post";
            break;
        case EXORpcDispactMethodHttpPut:
            args[@"method"] = @"http_put";
            break;
        case EXORpcDispactMethodSms:
            args[@"method"] = @"sms";
            break;
        case EXORpcDispactMethodXmpp:
            args[@"method"] = @"xmpp";
            break;
    }
    if (self.name) {
        args[@"name"] = self.name;
    }
    if (self.preprocess) {
        args[@"preprocess"] = self.preprocess;
    }
    args[@"public"] = @(self.public);
    if (self.recipient) {
        args[@"recipient"] = self.recipient;
    }
    if (self.retentionCount || self.retentionDuration) {
        NSMutableDictionary *reten = [NSMutableDictionary dictionary];
        if (self.retentionCount) {
            reten[@"count"] = self.retentionCount;
        }
        if (self.retentionDuration) {
            reten[@"duration"] = self.retentionDuration;
        }
        args[@"retention"] = [reten copy];
    }
    if (self.subject) {
        args[@"subject"] = self.subject;
    }
    if (self.subscribe) {
        args[@"subscribe"] = [self.subscribe plistValue];
    }

    return @[@"dispatch", [args copy]];
}

@end
