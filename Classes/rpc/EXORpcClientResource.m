//
//  EXORpcCreateClientRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcClientResource.h"

@implementation EXORpcClientResource

- (NSString *)type
{
    return @"client";
}

- (id)plistValue
{
    NSMutableDictionary *limits = [NSMutableDictionary dictionaryWithCapacity:15];
    if (self.limitClient) {
        limits[@"client"] = self.limitClient;
    } else {
        limits[@"client"] = @"inherit";
    }
    if (self.limitDataport) {
        limits[@"dataport"] = self.limitDataport;
    } else {
        limits[@"dataport"] = @"inherit";
    }
    if (self.limitDatarule) {
        limits[@"datarule"] = self.limitDatarule;
    } else {
        limits[@"datarule"] = @"inherit";
    }
    if (self.limitDisk) {
        limits[@"disk"] = self.limitDisk;
    } else {
        limits[@"disk"] = @"inherit";
    }
    if (self.limitDispatch) {
        limits[@"dispatch"] = self.limitDispatch;
    } else {
        limits[@"dispatch"] = @"inherit";
    }
    if (self.limitIO) {
        limits[@"io"] = self.limitIO;
    } else {
        limits[@"io"] = @"inherit";
    }
    if (self.limitEmail) {
        limits[@"email"] = self.limitEmail;
    } else {
        limits[@"email"] = @"inherit";
    }
    if (self.limitEmailBucket) {
        limits[@"email_bucket"] = self.limitEmailBucket;
    } else {
        limits[@"email_bucket"] = @"inherit";
    }
    if (self.limitHttp) {
        limits[@"http"] = self.limitHttp;
    } else {
        limits[@"http"] = @"inherit";
    }
    if (self.limitHttpBucket) {
        limits[@"http_bucket"] = self.limitHttpBucket;
    } else {
        limits[@"http_bucket"] = @"inherit";
    }
    if (self.limitShare) {
        limits[@"share"] = self.limitShare;
    } else {
        limits[@"share"] = @"inherit";
    }
    if (self.limitSms) {
        limits[@"sms"] = self.limitSms;
    } else {
        limits[@"sms"] = @"inherit";
    }
    if (self.limitSmsBucket) {
        limits[@"sms_bucket"] = self.limitSmsBucket;
    } else {
        limits[@"sms_bucket"] = @"inherit";
    }
    if (self.limitXmpp) {
        limits[@"xmpp"] = self.limitXmpp;
    } else {
        limits[@"xmpp"] = @"inherit";
    }
    if (self.limitXmppBucket) {
        limits[@"xmpp_bucket"] = self.limitXmppBucket;
    } else {
        limits[@"xmpp_bucket"] = @"inherit";
    }
    
    NSMutableDictionary *args = [NSMutableDictionary dictionaryWithCapacity:5];
    args[@"limits"] = [limits copy];
    if (self.locked) {
        args[@"locked"] = @YES;
    }
    if (self.meta) {
        args[@"meta"] = self.meta;
    }
    if (self.name) {
        args[@"name"] = self.name;
    }
    if (self.public) {
        args[@"public"] = @YES;
    }

    return [args copy];
}

@end
