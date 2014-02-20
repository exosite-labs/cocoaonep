//
//  EXOOnepCreateRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepCreateRequest.h"

@interface EXOOnepCreateRequest ()
@property(nonatomic,copy) EXOOnepResource *resource;
@property(nonatomic,copy) EXOOnepCreateRequestComplete complete;
@end

@implementation EXOOnepCreateRequest

+ (EXOOnepCreateRequest *)createWithResource:(EXOOnepResource *)resource complete:(EXOOnepCreateRequestComplete)complete
{
    return [[EXOOnepCreateRequest alloc] initWithResource:resource complete:complete];
}

- (id)init
{
    return nil;
}

- (id)initWithResource:(EXOOnepResource *)resource complete:(EXOOnepCreateRequestComplete)complete
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
    return @{@"procedure": @"create", @"arguments": self.resource};
}

- (void)doResult:(NSDictionary *)result error:(NSError *)error
{
    if (self.complete) {
        NSError *err = [self errorFromStatus:result];
        if (err) {
            self.complete(nil, err);
        } else {
            NSString *rid = result[@"result"]; // FIXME: Add type checking.
            EXOOnepResourceID *trid = [EXOOnepResourceID resourceIDByRID:rid];
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
