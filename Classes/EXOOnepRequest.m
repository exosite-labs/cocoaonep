//
//  EXOOnepRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepRequest.h"

NSString *kEXOOnepErrorDomain = @"kEXOOnepErrorDomain";

@implementation EXOOnepRequest

- (id)init
{
    return [self initWithRID:[EXOOnepResourceID resourceIDAsSelf]];
}

- (instancetype)initWithRID:(EXOOnepResourceID *)rid
{
    if (self = [super init]) {
        self.rid = rid;
    }
    return self;
}

- (NSInteger)codeFromStatus:(NSString*)status
{
    if ([status isEqualToString:@"ok"]) {
        return kEXOOnepErrorTypeOk;
    } else if ([status isEqualToString:@"invalid"]) {
        return kEXOOnepErrorTypeInvalid;
    } else if ([status isEqualToString:@"noauth"]) {
        return kEXOOnepErrorTypeNoAuth;
    }
    // TODO: This is probably incomplete. Documentation is lacking for this.
    return kEXOOnepErrorTypeUnknown;
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
        return [NSError errorWithDomain:@"EXOOnepDevice" code:ec userInfo:@{NSLocalizedDescriptionKey: desc}];
    }
    NSString *ds = [status[@"status"] description];
    NSInteger ec = [self codeFromStatus:ds];
    return [NSError errorWithDomain:kEXOOnepErrorDomain code:ec userInfo:@{NSLocalizedDescriptionKey: ds}];
}

- (void)doResult:(NSDictionary *)result error:(NSError *)error
{
    NSError *err = [self errorFromStatus:result];
    if (err) {
        @throw [NSException exceptionWithName:@"dude" reason:[err description] userInfo:nil];
    }
}

- (NSDictionary *)asCall
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
    return [NSString stringWithFormat:@"<%@: %p, %@>", NSStringFromClass([self class]), self, [self asCall]];
}

@end
