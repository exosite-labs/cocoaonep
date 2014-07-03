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
@property(copy,nonatomic) id json;

@end

@implementation EXORpcValue

+ (BOOL)supportsSecureCoding
{
    return YES;
}

+ (EXORpcValue *)valueWithDate:(NSDate *)when json:(id)json
{
    if (![NSJSONSerialization isValidJSONObject:json]) {
        return nil;
    }
    NSError *err=nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:json options:0 error:&err];
    if (data == nil || err != nil) {
        return nil;
    }
    NSString *value = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    return [[EXORpcValue alloc] initWithDate:when string:value];
}

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
        _when = [when copy];
        _numberValue = [value copy];
    }
    return self;
}

- (instancetype)initWithDate:(NSDate *)when string:(NSString *)value
{
    if (self = [super init]) {
        _when = [when copy];
        _stringValue = [value copy];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _when = [aDecoder decodeObjectOfClass:[self class] forKey:NSStringFromSelector(@selector(when))];
        _stringValue = [aDecoder decodeObjectOfClass:[self class] forKey:NSStringFromSelector(@selector(stringValue))];
        _numberValue = [aDecoder decodeObjectOfClass:[self class] forKey:NSStringFromSelector(@selector(numberValue))];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_when forKey:NSStringFromSelector(@selector(when))];
    [aCoder encodeObject:_stringValue forKey:NSStringFromSelector(@selector(stringValue))];
    [aCoder encodeObject:_numberValue forKey:NSStringFromSelector(@selector(numberValue))];
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

- (id)json
{
    if (_json) {
        return [_json copy]; // TODO: ???deep copy?
    }
    if (_stringValue != nil) {
        NSError *err=nil;
        NSData *data = [_stringValue dataUsingEncoding:NSUTF8StringEncoding];
        id plist = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
        if (plist == nil || err != nil) {
            return nil;
        }
        _json = plist;
        return _json;
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
