//
//  EXORpcResourceRetention.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcResourceRetention.h"

@interface EXORpcResourceRetention ()
@property(copy,nonatomic) NSNumber *count;
@property(copy,nonatomic) NSNumber *duration;
@end

@implementation EXORpcResourceRetention

+ (EXORpcResourceRetention *)retentionWithCount:(NSNumber *)count duration:(NSNumber *)duration
{
    return [[EXORpcResourceRetention alloc] initWithCount:count duration:duration];
}

- (instancetype)initWithCount:(NSNumber *)count duration:(NSNumber *)duration
{
    if (self = [self init]) {
        self.count = count;
        self.duration = duration;
    }
    return self;
}

- (instancetype)initWithPList:(NSDictionary *)plist
{
    NSNumber *count=nil;
    NSNumber *duration=nil;
    if (plist[@"count"]) {
        if (![plist[@"count"] isEqual:@"infinity"] && [plist[@"count"] isKindOfClass:[NSNumber class]]) {
            count = plist[@"count"];
        }
    }
    if (plist[@"duration"]) {
        if (![plist[@"duration"] isEqual:@"infinity"] && [plist[@"duration"] isKindOfClass:[NSNumber class]]) {
            duration = plist[@"duration"];
        }
    }
    return [self initWithCount:count duration:duration];
}

- (NSDictionary*)plistValue
{
    NSMutableDictionary *res = [NSMutableDictionary new];
    if (self.count) {
        res[@"count"] = self.count;
    } else {
        res[@"count"] = @"infinity";
    }
    if (self.duration) {
        res[@"duration"] = self.duration;
    } else {
        res[@"duration"] = @"infinity";
    }
    return [res copy];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p, %@>", NSStringFromClass([self class]), self, [self plistValue]];
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    EXORpcResourceRetention *obj = object;
    return (self.count == nil || [self.count isEqualToNumber:obj.count]) && (self.duration == nil || [self.duration isEqualToNumber:obj.duration]);
}

- (NSUInteger)hash
{
    return self.count.hash ^ self.duration.hash;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}


@end
