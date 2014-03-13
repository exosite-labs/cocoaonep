//
//  EXORpcFlushRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcFlushRequest.h"

@interface EXORpcFlushRequest ()
@property(nonatomic,copy) NSDate *newerthan;
@property(nonatomic,copy) NSDate *olderthan;
@property(nonatomic,copy) EXORpcRequestComplete complete;
@end

@implementation EXORpcFlushRequest

+ (EXORpcFlushRequest *)flushRID:(EXORpcResourceID *)rid newerThan:(NSDate *)newerthan olderThan:(NSDate *)olderthan complete:(EXORpcRequestComplete)complete
{
    return [[EXORpcFlushRequest alloc] initWithRID:rid newerThan:newerthan olderThan:olderthan complete:complete];
}

- (id)initWithRID:(EXORpcResourceID *)rid newerThan:(NSDate *)newerthan olderThan:(NSDate *)olderthan complete:(EXORpcRequestComplete)complete
{
    if (self = [super initWithRID:rid]) {
        self.newerthan = newerthan;
        self.olderthan = olderthan;
        self.complete = complete;
    }
    return self;
}

- (void)doResult:(NSDictionary *)result error:(NSError *)error
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
    NSMutableDictionary *args = [NSMutableDictionary dictionaryWithCapacity:2];
    if (self.newerthan) {
        args[@"newerthan"] = @([self.newerthan timeIntervalSince1970]);
    }
    if (self.olderthan) {
        args[@"olderthan"] = @([self.olderthan timeIntervalSince1970]);
    }
    return @{ @"procedure": @"flush", @"arguments": @[[self.rid plistValue], args]};
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    EXORpcFlushRequest *obj = object;
    return ([self.rid isEqual:obj.rid] &&
            ((self.newerthan == nil && obj.newerthan == nil) || [self.newerthan isEqualToDate:obj.newerthan]) &&
            ((self.olderthan == nil && obj.olderthan == nil) || [self.olderthan isEqualToDate:obj.olderthan])
            );
}

- (NSUInteger)hash
{
    return self.newerthan.hash ^ self.olderthan.hash ^ self.rid.hash;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

@end
