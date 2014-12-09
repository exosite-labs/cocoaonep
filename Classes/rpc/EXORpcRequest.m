//
//  EXORpcRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcRequest.h"

NSString *kEXORpcErrorDomain = @"kEXORpcErrorDomain";

@implementation EXORpcRequest

- (id)init
{
    return [self initWithRID:[EXORpcResourceID resourceIDAsSelf]];
}

- (instancetype)initWithRID:(EXORpcResourceID *)rid
{
    if (self = [super init]) {
        self.rid = rid;
    }
    return self;
}

- (NSInteger)codeFromStatus:(NSString*)status
{
    if ([status isEqualToString:@"ok"]) {
        return kEXORpcErrorTypeOk;
    } else if ([status isEqualToString:@"invalid"]) {
        return kEXORpcErrorTypeInvalid;
    } else if ([status isEqualToString:@"noauth"]) {
        return kEXORpcErrorTypeNoAuth;
    } else if ([status isEqualToString:@"expire"]) {
        return kEXORpcErrorTypeExpired;
    }
    // TODO: This is probably incomplete. Documentation is lacking for this.
    return kEXORpcErrorTypeUnknown;
}

- (NSError*)errorFromStatus:(NSDictionary*)status
{
    if ([status[@"status"] isEqualToString:@"ok"]) {
        return nil;
    }
    if (status[@"error"]) {
        NSDictionary *er = status[@"error"];
        NSInteger ec = [er[@"code"] integerValue];
        NSString *desc = [NSString stringWithFormat:@"msg: %@  context: %@", er[@"message"], er[@"context"]];
        return [NSError errorWithDomain:@"EXORpcDevice" code:ec userInfo:@{NSLocalizedDescriptionKey: desc}];
    }
    NSString *ds = [status[@"status"] description];
    NSInteger ec = [self codeFromStatus:ds];
    return [NSError errorWithDomain:kEXORpcErrorDomain code:ec userInfo:@{NSLocalizedDescriptionKey: ds}];
}

- (void)doResult:(NSDictionary *)result
{
    NSError *err = [self errorFromStatus:result];
    if (err) {
        @throw [NSException exceptionWithName:@"dude" reason:[err description] userInfo:nil];
    }
}

- (NSDictionary *)plistValue
{
    return @{};
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    return [self.rid isEqual:[object rid]];
}

- (NSUInteger)hash
{
    return self.rid.hash;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p, %@>", NSStringFromClass([self class]), self, [self plistValue]];
}

@end
