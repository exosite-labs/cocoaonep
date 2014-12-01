//
//  EXORpcCreateClientRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcClientResource.h"

@interface EXORpcClientResource ()
@property(assign,nonatomic) BOOL locked;

@property(copy,nonatomic) NSNumber *limitClient;
@property(copy,nonatomic) NSNumber *limitDataport;
@property(copy,nonatomic) NSNumber *limitDatarule;
@property(copy,nonatomic) NSNumber *limitDisk;
@property(copy,nonatomic) NSNumber *limitDispatch;
@property(copy,nonatomic) NSNumber *limitIO;
@property(copy,nonatomic) NSNumber *limitEmail;
@property(copy,nonatomic) NSNumber *limitEmailBucket;
@property(copy,nonatomic) NSNumber *limitHttp;
@property(copy,nonatomic) NSNumber *limitHttpBucket;
@property(copy,nonatomic) NSNumber *limitShare;
@property(copy,nonatomic) NSNumber *limitSms;
@property(copy,nonatomic) NSNumber *limitSmsBucket;
@property(copy,nonatomic) NSNumber *limitXmpp;
@property(copy,nonatomic) NSNumber *limitXmppBucket;
@end

@implementation EXORpcClientResource

+ (EXORpcClientResource *)resourceWithName:(NSString *)name meta:(NSString *)meta public:(BOOL)public locked:(BOOL)locked limits:(NSDictionary *)limits
{
    return [[EXORpcClientResource alloc] initWithName:name meta:meta public:public locked:locked limits:limits];
}

+ (EXORpcClientResource *)resourceWithName:(NSString *)name meta:(NSString *)meta
{
    return [[EXORpcClientResource alloc] initWithName:name meta:meta public:NO locked:NO limits:nil];
}

- (id)init
{
    return nil;
}

- (instancetype)initWithPList:(NSDictionary *)plist
{
    // Key check.
    if (plist[@"name"] == nil ||
        plist[@"meta"] == nil ||
        plist[@"public"] == nil ||
        plist[@"locked"] == nil ||
        plist[@"limits"] == nil) {
        return nil;
    }

    return [self initWithName:plist[@"name"] meta:plist[@"meta"] public:[plist[@"public"] boolValue] locked:[plist[@"locked"] boolValue] limits:plist[@"limits"]];
}

- (instancetype)initWithName:(NSString *)name meta:(NSString *)meta public:(BOOL)public locked:(BOOL)locked limits:(NSDictionary *)limits
{
    if (self = [super initWithName:name meta:meta public:public]) {
        self.locked = locked;
        if (limits[@"client"] && [limits[@"client"] isKindOfClass:[NSNumber class]]) {
            self.limitClient = limits[@"client"];
        }
        if (limits[@"limitClient"] && [limits[@"limitClient"] isKindOfClass:[NSNumber class]]) {
            self.limitClient = limits[@"limitClient"];
        }
        if (limits[@"dataport"] && [limits[@"dataport"] isKindOfClass:[NSNumber class]]) {
            self.limitDataport = limits[@"dataport"];
        }
        if (limits[@"limitDataport"] && [limits[@"limitDataport"] isKindOfClass:[NSNumber class]]) {
            self.limitDataport = limits[@"limitDataport"];
        }
        if (limits[@"datarule"] && [limits[@"datarule"] isKindOfClass:[NSNumber class]]) {
            self.limitDatarule = limits[@"datarule"];
        }
        if (limits[@"limitDatarule"] && [limits[@"limitDatarule"] isKindOfClass:[NSNumber class]]) {
            self.limitDatarule = limits[@"limitDatarule"];
        }
        if (limits[@"disk"] && [limits[@"disk"] isKindOfClass:[NSNumber class]]) {
            self.limitDisk = limits[@"disk"];
        }
        if (limits[@"limitDisk"] && [limits[@"limitDisk"] isKindOfClass:[NSNumber class]]) {
            self.limitDisk = limits[@"limitDisk"];
        }
        if (limits[@"dispatch"] && [limits[@"dispatch"] isKindOfClass:[NSNumber class]]) {
            self.limitDispatch = limits[@"dispatch"];
        }
        if (limits[@"limitDispatch"] && [limits[@"limitDispatch"] isKindOfClass:[NSNumber class]]) {
            self.limitDispatch = limits[@"limitDispatch"];
        }
        if (limits[@"IO"] && [limits[@"IO"] isKindOfClass:[NSNumber class]]) {
            self.limitIO = limits[@"IO"];
        }
        if (limits[@"limitIO"] && [limits[@"limitIO"] isKindOfClass:[NSNumber class]]) {
            self.limitIO = limits[@"limitIO"];
        }
        if (limits[@"email"] && [limits[@"email"] isKindOfClass:[NSNumber class]]) {
            self.limitEmail = limits[@"email"];
        }
        if (limits[@"limitEmail"] && [limits[@"limitEmail"] isKindOfClass:[NSNumber class]]) {
            self.limitEmail = limits[@"limitEmail"];
        }
        if (limits[@"emailBucket"] && [limits[@"emailBucket"] isKindOfClass:[NSNumber class]]) {
            self.limitEmailBucket = limits[@"emailBucket"];
        }
        if (limits[@"limitEmailBucket"] && [limits[@"limitEmailBucket"] isKindOfClass:[NSNumber class]]) {
            self.limitEmailBucket = limits[@"limitEmailBucket"];
        }
        if (limits[@"http"] && [limits[@"http"] isKindOfClass:[NSNumber class]]) {
            self.limitHttp = limits[@"http"];
        }
        if (limits[@"limitHttp"] && [limits[@"limitHttp"] isKindOfClass:[NSNumber class]]) {
            self.limitHttp = limits[@"limitHttp"];
        }
        if (limits[@"httpBucket"] && [limits[@"httpBucket"] isKindOfClass:[NSNumber class]]) {
            self.limitHttpBucket = limits[@"httpBucket"];
        }
        if (limits[@"limitHttpBucket"] && [limits[@"limitHttpBucket"] isKindOfClass:[NSNumber class]]) {
            self.limitHttpBucket = limits[@"limitHttpBucket"];
        }
        if (limits[@"share"] && [limits[@"share"] isKindOfClass:[NSNumber class]]) {
            self.limitShare = limits[@"share"];
        }
        if (limits[@"limitShare"] && [limits[@"limitShare"] isKindOfClass:[NSNumber class]]) {
            self.limitShare = limits[@"limitShare"];
        }
        if (limits[@"sms"] && [limits[@"sms"] isKindOfClass:[NSNumber class]]) {
            self.limitSms = limits[@"sms"];
        }
        if (limits[@"limitSms"] && [limits[@"limitSms"] isKindOfClass:[NSNumber class]]) {
            self.limitSms = limits[@"limitSms"];
        }
        if (limits[@"smsBucket"] && [limits[@"smsBucket"] isKindOfClass:[NSNumber class]]) {
            self.limitSmsBucket = limits[@"smsBucket"];
        }
        if (limits[@"limitSmsBucket"] && [limits[@"limitSmsBucket"] isKindOfClass:[NSNumber class]]) {
            self.limitSmsBucket = limits[@"limitSmsBucket"];
        }
        if (limits[@"xmpp"] && [limits[@"xmpp"] isKindOfClass:[NSNumber class]]) {
            self.limitXmpp = limits[@"xmpp"];
        }
        if (limits[@"limitXmpp"] && [limits[@"limitXmpp"] isKindOfClass:[NSNumber class]]) {
            self.limitXmpp = limits[@"limitXmpp"];
        }
        if (limits[@"xmppBucket"] && [limits[@"xmppBucket"] isKindOfClass:[NSNumber class]]) {
            self.limitXmppBucket = limits[@"xmppBucket"];
        }
        if (limits[@"limitXmppBucket"] && [limits[@"limitXmppBucket"] isKindOfClass:[NSNumber class]]) {
            self.limitXmppBucket = limits[@"limitXmppBucket"];
        }
    }
    return self;
}

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
    } else {
        args[@"locked"] = @NO;
    }
    if (self.meta) {
        args[@"meta"] = self.meta;
    }
    if (self.name) {
        args[@"name"] = self.name;
    }
    if (self.public) {
        args[@"public"] = @YES;
    } else {
        args[@"public"] = @NO;
    }

    return [args copy];
}

@end
