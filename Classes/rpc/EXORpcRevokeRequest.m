//
//  EXORpcRevokeRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcRevokeRequest.h"

@implementation EXORpcRevokeRequest


+ (EXORpcRevokeRequest *)revokeWithCode:(NSString *)code asShare:(BOOL)asShare complete:(EXORpcRequestComplete)complete
{
    return [[EXORpcRevokeRequest alloc] initWithCode:code asShare:asShare complete:complete];
}

- (instancetype)initWithCode:(NSString *)code asShare:(BOOL)asShare complete:(EXORpcRequestComplete)complete
{
    if (self = [super init]) {
        _code = [code copy];
        _asShare = asShare;
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
            self.complete(err);
        } else {
            self.complete(nil);
        }
    }
}

- (NSDictionary *)plistValue
{
    return @{ @"procedure": @"revoke", @"arguments": @[(self.asShare?@"share":@"client"), [self.code copy]]};
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    return [self.rid isEqual:[object rid]] &&
            self.asShare == [object asShare] &&
            [self.code isEqualToString:[(EXORpcRevokeRequest*)object code]];
}

- (NSUInteger)hash
{
    return self.rid.hash ^ self.code.hash ^ self.asShare;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}


@end
