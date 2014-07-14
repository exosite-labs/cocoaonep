//
//  EXORpcCreateDispatchRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcDispatchResource.h"

@interface EXORpcDispatchResource ()
@property(assign,nonatomic) BOOL locked;
@property(copy,nonatomic) NSString *message;
@property(assign,nonatomic) EXORpcDispactMethod_t method;
@property(copy,nonatomic) NSArray *preprocess;
@property(copy,nonatomic) NSString *recipient;
@property(copy,nonatomic) EXORpcResourceRetention *retention;
@property(copy,nonatomic) NSString *subject;
@property(copy,nonatomic) EXORpcResourceID *subscribe;
@end

@implementation EXORpcDispatchResource

+ (EXORpcDispatchResource *)dispatchEmailTo:(NSString *)recipient subject:(NSString *)subject message:(NSString *)message on:(EXORpcResourceID *)subscribed
{
    // TODO: Validate that recipient is an email address
    return [[EXORpcDispatchResource alloc] initWithName:nil meta:nil method:EXORpcDispactMethodEmail to:recipient subject:subject message:message on:subscribed locked:NO public:NO preprocess:nil retention:nil];
}

+ (EXORpcDispatchResource *)dispatchSMSTo:(NSString *)recipient message:(NSString *)message on:(EXORpcResourceID *)subscribed
{
    // TODO: Validate that recipient is a phone number
    return [[EXORpcDispatchResource alloc] initWithName:nil meta:nil method:EXORpcDispactMethodSms to:recipient subject:nil message:message on:subscribed locked:NO public:NO preprocess:nil retention:nil];
}

+ (EXORpcDispatchResource *)dispatchWithName:(NSString*)name method:(EXORpcDispactMethod_t)method to:(NSString *)recipient subject:(NSString *)subject message:(NSString *)message on:(EXORpcResourceID *)subscribed
{
    return [[EXORpcDispatchResource alloc] initWithName:name meta:nil method:method to:recipient subject:subject message:message on:subscribed locked:NO public:NO preprocess:nil retention:nil];
}

- (instancetype)initWithName:(NSString *)name meta:(NSString *)meta method:(EXORpcDispactMethod_t)method to:(NSString *)recipient subject:(NSString *)subject message:(NSString *)message on:(EXORpcResourceID *)subscribed locked:(BOOL)locked public:(BOOL)public preprocess:(NSArray *)preprocess retention:(EXORpcResourceRetention *)retention
{
    if (self = [super initWithName:name meta:meta public:public]) {
        _locked = locked;
        _message = [message copy];
        _method = method;
        _preprocess = [preprocess copy];
        _recipient = [recipient copy];
        _retention = [retention copy];
        _subject = [subject copy];
        _subscribe = [subscribed copy];
    }
    return self;
}

- (instancetype)initWithPList:(NSDictionary *)plist
{
    EXORpcDispactMethod_t method;
    if (plist[@"method"] == nil) {
        return nil;
    } else if ([plist[@"method"] isEqualToString:@"email"]) {
        method = EXORpcDispactMethodEmail;
    } else if ([plist[@"method"] isEqualToString:@"http_get"]) {
        method = EXORpcDispactMethodHttpGet;
    } else if ([plist[@"method"] isEqualToString:@"http_post"]) {
        method = EXORpcDispactMethodHttpPost;
    } else if ([plist[@"method"] isEqualToString:@"http_put"]) {
        method = EXORpcDispactMethodHttpPut;
    } else if ([plist[@"method"] isEqualToString:@"sms"]) {
        method = EXORpcDispactMethodSms;
    } else if ([plist[@"method"] isEqualToString:@"xmpp"]) {
        method = EXORpcDispactMethodXmpp;
    } else {
        return nil;
    }
    NSString *name = plist[@"name"];
    NSString *meta = plist[@"meta"];
    NSString *recipient = plist[@"recipient"];
    NSString *subject = plist[@"subject"];
    NSString *message = plist[@"message"];
    if (plist[@"subscribe"] == nil) {
        return nil;
    }
    EXORpcResourceID *subscribed = [EXORpcResourceID resourceIDByRID:plist[@"subscribe"]];
    EXORpcResourceRetention *retention = [[EXORpcResourceRetention alloc] initWithPList:plist[@"retention"]];
    NSMutableArray *preprocess = [NSMutableArray new];
    for (NSArray *pp in plist[@"preprocess"]) {
        [preprocess addObject:[[EXORpcPreprocessOperation alloc] initWithPList:pp]];
    }

    return [self initWithName:name meta:meta method:method to:recipient subject:subject message:message on:subscribed locked:[plist[@"locked"] boolValue] public:[plist[@"public"] boolValue] preprocess:preprocess retention:retention];
}

- (id)init
{
    return nil;
}

- (NSString *)type
{
    return @"dispatch";
}


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
        NSMutableArray *pps = [NSMutableArray new];
        for (EXORpcPreprocessOperation *pp in self.preprocess) {
            [pps addObject:[pp plistValue]];
        }
        args[@"preprocess"] = [pps copy];
    }
    args[@"public"] = @(self.public);
    if (self.recipient) {
        args[@"recipient"] = self.recipient;
    }
    if (self.retention) {
        args[@"retention"] = [self.retention plistValue];
    }
    if (self.subject) {
        args[@"subject"] = self.subject;
    }
    if (self.subscribe) {
        args[@"subscribe"] = [self.subscribe plistValue];
    }

    return [args copy];
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }

    BOOL okLocked = _locked == [object locked];
    BOOL okMsg = (_message == nil && [object message] == nil) || [_message isEqualToString:[object message]];
    BOOL okMethod = _method == [object method];
    BOOL okPreprocess = (_preprocess == nil && [object preprocess] == nil) || [_preprocess isEqualToArray:[object preprocess]];
    BOOL okRecipient = (_recipient == nil && [object recipient] == nil) || [_recipient isEqualToString:[object recipient]];
    BOOL okRetention = (_retention == nil && [object retention] == nil) || [_retention isEqual:[object retention]];
    BOOL okSubject = (_subject == nil && [object subject] == nil) || [_subject isEqualToString:[object subject]];
    BOOL okSubscribe = (_subscribe == nil && [object subscribe] == nil) || [_subscribe isEqual:[object subscribe]];

    return okLocked && okMsg && okMethod && okPreprocess && okRecipient && okRetention && okSubject &&okSubscribe;
}

- (NSUInteger)hash
{
    return _locked ^ _message.hash ^ _method ^ _preprocess.hash ^ _recipient.hash ^ _retention.hash ^ _subject.hash ^ _subscribe.hash;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

@end
