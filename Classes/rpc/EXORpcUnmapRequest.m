//
//  EXORpcUnmapRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcUnmapRequest.h"

@interface EXORpcUnmapRequest ()
@property(copy,nonatomic) NSString *alias;
@property(copy,nonatomic) EXORpcRequestComplete complete;
@end

@implementation EXORpcUnmapRequest

+ (EXORpcUnmapRequest *)unmapWithAlias:(NSString *)alias complete:(EXORpcRequestComplete)complete
{
    return [[EXORpcUnmapRequest alloc] initWithAlias:alias complete:complete];
}

- (instancetype)initWithAlias:(NSString *)alias complete:(EXORpcRequestComplete)complete
{
    if (self = [super init]) {
        _alias = [alias copy];
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
    return @{ @"procedure": @"unmap", @"arguments": @[@"alias", self.alias]};
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    return [self.alias isEqual:[object alias]];
}

- (NSUInteger)hash
{
    return self.alias.hash;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}


@end
