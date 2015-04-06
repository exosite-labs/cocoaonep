//
//  EXORpcActivateRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcActivateRequest.h"

@interface EXORpcActivateRequest ()
@property(assign,nonatomic) BOOL asShare;
@property(copy,nonatomic) NSString *code;
@property(copy,nonatomic) EXORpcRequestComplete complete;
@end

@implementation EXORpcActivateRequest

+ (EXORpcActivateRequest *)activateClientWithCode:(NSString *)code complete:(EXORpcRequestComplete)complete
{
    return [[EXORpcActivateRequest alloc] initWithShare:NO code:code complete:complete];
}

+ (EXORpcActivateRequest *)activateShareWithCode:(NSString *)code complete:(EXORpcRequestComplete)complete
{
    return [[EXORpcActivateRequest alloc] initWithShare:YES code:code complete:complete];
}

- (instancetype)initWithShare:(BOOL)share code:(NSString *)code complete:(EXORpcRequestComplete)complete
{
    if (self = [super init]) {
        _asShare = share;
        _code = [code copy];
        _complete = [complete copy];
    }
    return self;
}

- (id)init
{
    return nil;
}

- (void)doResult:(NSDictionary*)result
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

- (NSDictionary*)plistValue
{
    return @{@"procedure": @"activate", @"arguments": @[(self.asShare?@"share":@"client"), self.code]};
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }

    return (_asShare == [object asShare]) && [_code isEqualToString:[(EXORpcActivateRequest*)object code]];
}

- (NSUInteger)hash
{
    return _asShare ^ _code.hash;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

@end
