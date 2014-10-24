//
//  EXORpcWaitRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//
//

#import "EXORpcWaitRequest.h"
#import "EXORpcValue.h"

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
        // Current wait command only takes a single RID. Future version will take multiple.
        _timeout = [timeout copy];
        _since = [since copy];
        _complete = [complete copy];
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
            NSArray *got = result[@"result"];
            // Current wait command reply returns a single value
            NSMutableDictionary *given = [NSMutableDictionary new];
            if (got.count > 0) {
                NSArray *item = got[0];
                NSDate *when = [NSDate dateWithTimeIntervalSince1970:[item[0] longLongValue]];
                EXORpcValue *rval;
                id value = item[1];
                if ([value isKindOfClass:[NSString class]]) {
                    rval = [EXORpcValue valueWithDate:when string:value];
                } else if ([value isKindOfClass:[NSNumber class]]) {
                    rval = [EXORpcValue valueWithDate:when number:value];
                } else {
                    rval = [EXORpcValue valueWithDate:when string:[value description]];
                }
                given[self.resourceIDs[0]] = rval;
                self.complete([given copy], nil);
            }
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
    // Current wait command only takes a single RID. Future version will take multiple.
    return @{@"procedure": @"wait", @"arguments": @[rids[0], [params copy]]};
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
