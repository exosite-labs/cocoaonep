//
//  EXOOnepFlushRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepFlushRequest.h"

@interface EXOOnepFlushRequest ()
@property(nonatomic,copy) NSDate *newerthan;
@property(nonatomic,copy) NSDate *olderthan;
@property(nonatomic,copy) EXOOnepRequestComplete complete;
@end

@implementation EXOOnepFlushRequest

+ (EXOOnepFlushRequest *)flushRID:(EXOOnepResourceID *)rid newerThan:(NSDate *)newerthan olderThan:(NSDate *)olderthan complete:(EXOOnepRequestComplete)complete
{
    return [[EXOOnepFlushRequest alloc] initWithRID:rid newerThan:newerthan olderThan:olderthan complete:complete];
}

- (id)initWithRID:(EXOOnepResourceID *)rid newerThan:(NSDate *)newerthan olderThan:(NSDate *)olderthan complete:(EXOOnepRequestComplete)complete
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

- (NSDictionary *)asCall
{
    NSMutableDictionary *args = [NSMutableDictionary dictionaryWithCapacity:2];
    if (self.newerthan) {
        args[@"newerthan"] = @([self.newerthan timeIntervalSince1970]);
    }
    if (self.olderthan) {
        args[@"olderthan"] = @([self.olderthan timeIntervalSince1970]);
    }
    return @{ @"procedure": @"flush", @"arguments": @[[self.rid asCall], args]};
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    EXOOnepFlushRequest *obj = object;
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
