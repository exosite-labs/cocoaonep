//
//  EXOOnepCreateDispatchRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepDispatchResource.h"

@implementation EXOOnepDispatchResource

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
        case EXOOnepDispactMethodEmail:
            args[@"method"] = @"email";
            break;
        case EXOOnepDispactMethodHttpGet:
            args[@"method"] = @"http_get";
            break;
        case EXOOnepDispactMethodHttpPost:
            args[@"method"] = @"http_post";
            break;
        case EXOOnepDispactMethodHttpPut:
            args[@"method"] = @"http_put";
            break;
        case EXOOnepDispactMethodSms:
            args[@"method"] = @"sms";
            break;
        case EXOOnepDispactMethodXmpp:
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
        args[@"retention"] = reten;
    }
    if (self.subject) {
        args[@"subject"] = self.subject;
    }
    if (self.subscribe) {
        args[@"subscribe"] = [self.subscribe plistValue];
    }

    return @[@"dispatch", args];
}

@end
