//
//  EXORpcDataruleTimeout.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcDataruleTimeout.h"

@interface EXORpcDataruleTimeout ()
@property(nonatomic,copy) NSNumber *timeout;
@property(nonatomic,assign) BOOL repeat;
@end

@implementation EXORpcDataruleTimeout

+ (EXORpcDataruleTimeout *)dataruleTimeoutWithTimeout:(NSNumber *)timeout repeat:(BOOL)repeat
{
    return [[EXORpcDataruleTimeout alloc] initWithTimeout:timeout repeat:repeat];
}

- (instancetype)initWithTimeout:(NSNumber *)timeout repeat:(BOOL)repeat
{
    if (self = [super init]) {
        _timeout = [timeout copy];
        _repeat = repeat;
    }
    return self;
}

- (id)init
{
    return nil;
}

- (NSDictionary *)plistValue
{
    return @{@"timeout": @{@"timeout": self.timeout, @"repeat": @(self.repeat)}};
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    EXORpcDataruleTimeout *obj = object;
    return ([self.timeout isEqualToNumber:obj.timeout] &&
            self.repeat == obj.repeat
            );
}

- (NSUInteger)hash
{
    return self.timeout.hash ^ self.repeat;
}

@end
