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
    return @{@"procedure": @"wait", @"arguments": @[nil, params]};
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
    // FIXME: handle nil weirdnesses. (timeout and since can be nil to mean defaults.)
    return [self.resourceIDs isEqualToArray:object.resourceIDs] &&
            [self.timeout isEqualToNumber:object.timeout] &&
    [self.since isEqualToDate:object.since];
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
