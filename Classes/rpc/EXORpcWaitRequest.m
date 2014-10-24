//
//  EXORpcWaitRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//
//

#import "EXORpcWaitRequest.h"

@interface EXORpcWaitRequest ()
@property (copy,nonatomic) NSArray *resourceIDs;
@property (copy,nonatomic) NSNumber *timeout;
@property (copy,nonatomic) NSDate *since;
@property (copy,nonatomic) EXORpcWaitRequestComplete complete;
@end

@implementation EXORpcWaitRequest

+ (EXORpcWaitRequest *)waitRequestWithRIDs:(NSArray *)rids complete:(EXORpcWaitRequestComplete)complete
{
    return [[EXORpcWaitRequest alloc] initWithRIDs:rids timeoutAfter:nil since:nil complete:complete];
}

+ (EXORpcWaitRequest *)waitRequestWithRIDs:(NSArray *)rids timeoutAfter:(NSNumber *)timeout complete:(EXORpcWaitRequestComplete)complete
{
    return [[EXORpcWaitRequest alloc] initWithRIDs:rids timeoutAfter:timeout since:nil complete:complete];
}

+ (EXORpcWaitRequest *)waitRequestWithRIDs:(NSArray *)rids timeoutAfter:(NSNumber *)timeout since:(NSDate *)since complete:(EXORpcWaitRequestComplete)complete
{
    return [[EXORpcWaitRequest alloc] initWithRIDs:rids timeoutAfter:timeout since:since complete:complete];
}

- (id)initWithRIDs:(NSArray *)rids timeoutAfter:(NSNumber *)timeout since:(NSDate *)since complete:(EXORpcWaitRequestComplete)complete
{
    if (self = [super init]) {
        _resourceIDs = [rids copy];
        _timeout = [timeout copy];
        _since = [since copy];
        _complete = [complete copy];
    }
    return self;
}

- (instancetype)initWithRID:(EXORpcResourceID *)rid
{
    return nil;
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
            // FIXME: parse results.
            self.complete(nil, nil);
        }
    }
}

- (NSDictionary *)plistValue
{
    NSMutableDictionary *params = [NSMutableDictionary new];
    if (self.timeout) {
        params[@"timeout"] = self.timeout;
    }
    if (self.since) {
        params[@"since"] = @([self.since timeIntervalSince1970]);
    }
    NSMutableArray *rids = [NSMutableArray new];
    for (EXORpcResourceID *rid in self.resourceIDs) {
        [rids addObject:[rid plistValue]];
    }
    return @{@"procedure": @"wait", @"arguments": @[[rids copy], [params copy]]};
    // May have found a syntax bug in the RPC call. so waiting on that.
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    return [self isEqualToWaitRequest:object];
}

- (BOOL)isEqualToWaitRequest:(EXORpcWaitRequest*)object
{
    return [self.resourceIDs isEqualToArray:object.resourceIDs] &&
    ((self.timeout == nil && [object timeout] == nil) || [self.timeout isEqualToNumber:[object timeout]]) &&
    ((self.since == nil && [object since] == nil) || [self.since isEqualToDate:[object since]]);
}

- (NSUInteger)hash
{
    return self.resourceIDs.hash ^ self.timeout.hash ^ self.since.hash;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

@end
