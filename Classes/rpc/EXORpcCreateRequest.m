//
//  EXORpcCreateRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcCreateRequest.h"

@interface EXORpcCreateRequest ()
@property(nonatomic,copy) EXORpcResource *resource;
@property(nonatomic,copy) EXORpcCreateRequestComplete complete;
@end

@implementation EXORpcCreateRequest

+ (EXORpcCreateRequest *)createWithResource:(EXORpcResource *)resource complete:(EXORpcCreateRequestComplete)complete
{
    return [[EXORpcCreateRequest alloc] initWithResource:resource complete:complete];
}

- (id)init
{
    return nil;
}

- (id)initWithResource:(EXORpcResource *)resource complete:(EXORpcCreateRequestComplete)complete
{
    self = [super init];
    if (self) {
        self.resource = resource;
        self.complete = complete;
    }
    return self;
}

- (NSDictionary *)plistValue
{
    return @{@"procedure": @"create", @"arguments": @[self.resource.type, [self.resource plistValue]]};
}

- (void)doResult:(NSDictionary *)result error:(NSError *)error
{
    if (self.complete) {
        NSError *err = [self errorFromStatus:result];
        if (err) {
            self.complete(nil, err);
        } else {
            NSString *rid = result[@"result"]; // FIXME: Add type checking.
            EXORpcResourceID *trid = [EXORpcResourceID resourceIDByRID:rid];
            self.complete(trid, nil);
        }
    }
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p, Res: %@>", NSStringFromClass([self class]), self, self.resource];
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    return [self.resource isEqual:[object resource]];
}

- (NSUInteger)hash
{
    return self.resource.hash;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

@end
