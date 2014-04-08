//
//  EXORpcUpdateRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcUpdateRequest.h"

@interface EXORpcUpdateRequest ()
@property(nonatomic,copy) EXORpcResource *resource;
@property(nonatomic,copy) EXORpcUpdateRequestComplete complete;
@end

@implementation EXORpcUpdateRequest

+ (EXORpcUpdateRequest *)updateWithRID:(EXORpcResourceID*)rid resource:(EXORpcResource *)resource complete:(EXORpcUpdateRequestComplete)complete
{
    return [[EXORpcUpdateRequest alloc] initWithRID:rid resource:resource complete:complete];
}

- (id)init
{
    return nil;
}

- (id)initWithRID:(EXORpcResourceID*)rid resource:(EXORpcResource *)resource complete:(EXORpcUpdateRequestComplete)complete
{
    self = [super init];
    if (self) {
        self.rid = rid;
        self.resource = resource;
        self.complete = complete;
    }
    return self;
}

- (NSDictionary *)plistValue
{
    return @{@"procedure": @"update", @"arguments": @[[self.rid plistValue], [self.resource plistValue]] };
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
    return [NSString stringWithFormat:@"<%@: %p, RID: %@, Res: %@>", NSStringFromClass([self class]), self, self.rid, self.resource];
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    return [self.rid isEqual:[object rid]] && [self.resource isEqual:[object resource]];
}

- (NSUInteger)hash
{
    return self.rid.hash ^ self.resource.hash;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

@end
