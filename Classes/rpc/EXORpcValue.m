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

+ (EXORpcValue*)valueWithDate:(NSDate*)when string:(NSString*)value
{
    return [[EXORpcValue alloc] initWithDate:when string:value];
}

+ (EXORpcValue*)valueWithDate:(NSDate*)when number:(NSNumber*)value
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
        NSScanner *scanner = [NSScanner scannerWithString:_stringValue];
        double value = NAN;
        if([scanner scanDouble:&value]) {
            return @(value);
        } else {
            return nil;
        }
    }
    return nil;
}

- (id)plistValue
{
    NSNumber *when = @((NSUInteger)[self.when timeIntervalSince1970]);
    if (_stringValue != nil) {
        return @[when, [_stringValue copy]];
    } else if (_numberValue != nil) {
        return @[when, [_numberValue copy]];
    } else {
        return @[when, [NSNull null]];
    }
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
    EXORpcValue *obj = object;

    BOOL dateOk = [self.when isEqual:[object when]];
    BOOL stringOk = (_stringValue == nil && obj->_stringValue == nil) || ([_stringValue isEqualToString:obj->_stringValue]);
    BOOL numberOk = (_numberValue == nil && obj->_numberValue == nil) || ([_numberValue isEqualToNumber:obj->_numberValue]);;

    return dateOk && stringOk && numberOk;
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
