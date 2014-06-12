//
//  EXORpcShareRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcShareRequest.h"

@interface EXORpcShareRequest ()
@property(copy,nonatomic) EXORpcShareRequestComplete complete;
@property(copy,nonatomic) NSString *meta;
@end

@implementation EXORpcShareRequest

+ (EXORpcShareRequest *)shareWithRID:(EXORpcResourceID *)rid meta:(NSString *)meta
{
    return [[EXORpcShareRequest alloc] initWithRID:rid meta:meta];
}

+ (EXORpcShareRequest *)shareWithRID:(EXORpcResourceID *)rid
{
    return [[EXORpcShareRequest alloc] initWithRID:rid meta:nil];
}

- (instancetype)initWithRID:(EXORpcResourceID *)rid meta:(NSString *)meta
{
    if (self = [super initWithRID:rid]) {
        _meta = meta;
    }
    return self;
}

- (id)init
{
    return nil;
}

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

- (NSDictionary *)plistValue
{
    NSMutableDictionary *args = [NSMutableDictionary new];
    if (self.meta) {
        args[@"meta"] = [self.meta copy];
    }
    return @{ @"procedure": @"share", @"arguments": @[[self.rid plistValue], args]};
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    return [self.rid isEqual:[object rid]] && [self.meta isEqualToString:[object meta]];
}

- (NSUInteger)hash
{
    return self.rid.hash ^ self.meta.hash;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

@end
