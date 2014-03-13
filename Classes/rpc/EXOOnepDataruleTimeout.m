//
//  EXOOnepDataruleTimeout.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepDataruleTimeout.h"

@interface EXOOnepDataruleTimeout ()
@property(nonatomic,copy) NSNumber *timeout;
@property(nonatomic,assign) BOOL repeat;
@end

@implementation EXOOnepDataruleTimeout

+ (EXOOnepDataruleTimeout *)dataruleTimeoutWithTimeout:(NSNumber *)timeout repeat:(BOOL)repeat
{
    return [[EXOOnepDataruleTimeout alloc] initWithTimeout:timeout repeat:repeat];
}

- (instancetype)initWithTimeout:(NSNumber *)timeout repeat:(BOOL)repeat
{
    if (self = [super init]) {
        self.timeout = timeout;
        self.repeat = repeat;
    }
    return self;
}

- (id)init
{
    return nil;
}

- (NSDictionary *)plistValue
{
    return @{@"timeout": @{@"timeout": self.timeout, @"repeat": self.repeat?@"true":@"false"}};
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    EXOOnepDataruleTimeout *obj = object;
    return ([self.timeout isEqualToNumber:obj.timeout] &&
            self.repeat == obj.repeat
            );
}

- (NSUInteger)hash
{
    return self.timeout.hash ^ self.repeat;
}

@end
