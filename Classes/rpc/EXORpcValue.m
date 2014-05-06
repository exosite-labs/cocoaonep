//
//  EXORpcValue.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcValue.h"

@interface EXORpcValue ()
@property(copy,nonatomic) NSDate *when;
@property(copy,nonatomic) NSString *stringValue;
@property(copy,nonatomic) NSNumber *numberValue;
@end

@implementation EXORpcValue

- (EXORpcValue*)valueWithDate:(NSDate*)when string:(NSString*)value
{
    return [[EXORpcValue alloc] initWithDate:when string:value];
}

- (EXORpcValue*)valueWithDate:(NSDate*)when number:(NSNumber*)value
{
    return [[EXORpcValue alloc] initWithDate:when number:value];
}

- (instancetype)initWithDate:(NSDate *)when number:(NSNumber *)value
{
    if (self = [super init]) {
        _when = when;
        _numberValue = value;
    }
    return self;
}

- (instancetype)initWithDate:(NSDate *)when string:(NSString *)value
{
    if (self = [super init]) {
        _when = when;
        _stringValue = value;
    }
    return self;
}

- (NSString *)stringValue
{
    if (_stringValue != nil) {
        return [_stringValue copy];
    } else if (_numberValue != nil) {
        return [_numberValue stringValue];
    }
    return nil;
}

- (NSNumber *)numberValue
{
    if (_numberValue != nil) {
        return [_numberValue copy];
    } else if (_stringValue != nil) {
        return @([_stringValue doubleValue]);
    }
    return nil;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p, when: %@ value: %@>", NSStringFromClass([self class]), self, self.when, self.stringValue];
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    
    return [self.when isEqual:[object when]] &&
           [self.stringValue isEqual:[object stringValue]] &&
           [self.numberValue isEqual:[object numberValue]];
}

- (NSUInteger)hash
{
    return self.when.hash ^ _stringValue.hash ^ _numberValue.hash;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

@end
