//
//  EXORpcPreprocessOperation.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcPreprocessOperation.h"

@interface EXORpcPreprocessOperation ()
@property(assign,nonatomic) EXORpcPreprocessOperation_t operation;
@property(copy,nonatomic) NSNumber *value;
@property(copy,nonatomic) EXORpcResourceID *rid;
@end

@implementation EXORpcPreprocessOperation

+ (EXORpcPreprocessOperation *)preprocessOperation:(EXORpcPreprocessOperation_t)operation value:(NSNumber *)value
{
    return [[EXORpcPreprocessOperation alloc] initWithOperation:operation value:value];
}

+ (EXORpcPreprocessOperation *)preprocessOperation:(EXORpcPreprocessOperation_t)operation rid:(EXORpcResourceID *)rid
{
    return [[EXORpcPreprocessOperation alloc] initWithOperation:operation rid:rid];
}

- (id)init
{
    return nil;
}

- (instancetype)initWithOperation:(EXORpcPreprocessOperation_t)operation value:(NSNumber *)value
{
    if (self = [super init]) {
        _operation = operation;
        _value = [value copy];
    }
    return self;
}

- (instancetype)initWithOperation:(EXORpcPreprocessOperation_t)operation rid:(EXORpcResourceID *)rid
{
    if (rid.rid == nil) {
        return nil;
    }
    if (self = [super init]) {
        _operation = operation;
        _rid = [rid copy];
    }
    return self;
}

- (instancetype)initWithPList:(NSArray *)plist
{
    if (plist.count != 2) {
        return nil;
    }
    EXORpcPreprocessOperation_t op;
    if ([plist[0] isEqualToString:@"add"]) {
        op = EXORpcPreprocessOperation_Add;
    } else if ([plist[0] isEqualToString:@"sub"]) {
            op = EXORpcPreprocessOperation_Subtract;
    } else if ([plist[0] isEqualToString:@"mul"]) {
        op = EXORpcPreprocessOperation_Multiply;
    } else if ([plist[0] isEqualToString:@"div"]) {
        op = EXORpcPreprocessOperation_Divide;
    } else if ([plist[0] isEqualToString:@"mod"]) {
        op = EXORpcPreprocessOperation_Modulo;
    } else if ([plist[0] isEqualToString:@"gt"]) {
        op = EXORpcPreprocessOperation_GreaterThan;
    } else if ([plist[0] isEqualToString:@"geq"]) {
        op = EXORpcPreprocessOperation_GreaterThanOrEqual;
    } else if ([plist[0] isEqualToString:@"lt"]) {
        op = EXORpcPreprocessOperation_LessThan;
    } else if ([plist[0] isEqualToString:@"leq"]) {
        op = EXORpcPreprocessOperation_LessThanOrEqual;
    } else if ([plist[0] isEqualToString:@"eq"]) {
        op = EXORpcPreprocessOperation_Equal;
    } else if ([plist[0] isEqualToString:@"neq"]) {
        op = EXORpcPreprocessOperation_NotEqual;
    } else if ([plist[0] isEqualToString:@"value"]) {
        op = EXORpcPreprocessOperation_Value;
    } else {
        return nil;
    }

    id val = plist[1];
    if ([val isKindOfClass:[NSNumber class]]) {
        return [self initWithOperation:op value:val];
    } else if ([val isKindOfClass:[NSString class]]) {
        EXORpcResourceID *rid = [EXORpcResourceID resourceIDByRID:val];
        return [self initWithOperation:op rid:rid];
    }

    return nil;
}

- (NSString*)stringFromOperation:(EXORpcPreprocessOperation_t)operation
{
    NSString *op=nil;
    switch (operation) {
        case EXORpcPreprocessOperation_Add:
            op = @"add";
            break;
        case EXORpcPreprocessOperation_Subtract:
            op = @"sub";
            break;
        case EXORpcPreprocessOperation_Multiply:
            op = @"mul";
            break;
        case EXORpcPreprocessOperation_Divide:
            op = @"div";
            break;
        case EXORpcPreprocessOperation_Modulo:
            op = @"mod";
            break;
        case EXORpcPreprocessOperation_GreaterThan:
            op = @"gt";
            break;
        case EXORpcPreprocessOperation_GreaterThanOrEqual:
            op = @"geq";
            break;
        case EXORpcPreprocessOperation_LessThan:
            op = @"lt";
            break;
        case EXORpcPreprocessOperation_LessThanOrEqual:
            op = @"leq";
            break;
        case EXORpcPreprocessOperation_Equal:
            op = @"eq";
            break;
        case EXORpcPreprocessOperation_NotEqual:
            op = @"neq";
            break;
        case EXORpcPreprocessOperation_Value:
            op = @"value";
            break;
    }
    return op;
}

- (NSString*)utf8FromOperation:(EXORpcPreprocessOperation_t)operation
{
    NSString *opString=nil;
    switch (operation) {
        case EXORpcPreprocessOperation_Add: opString = @"+"; break;
        case EXORpcPreprocessOperation_Subtract: opString = @"-"; break;
        case EXORpcPreprocessOperation_Multiply: opString = @"×"; break;
        case EXORpcPreprocessOperation_Divide: opString = @"÷"; break;
        case EXORpcPreprocessOperation_Modulo: opString = @"%"; break;
        case EXORpcPreprocessOperation_Equal: opString = @"="; break;
        case EXORpcPreprocessOperation_NotEqual: opString = @"≠"; break;
        case EXORpcPreprocessOperation_GreaterThan: opString = @">"; break;
        case EXORpcPreprocessOperation_GreaterThanOrEqual: opString = @"≥"; break;
        case EXORpcPreprocessOperation_LessThan: opString = @"<"; break;
        case EXORpcPreprocessOperation_LessThanOrEqual: opString = @"≤"; break;
        case EXORpcPreprocessOperation_Value: opString = @"⇇"; break;
        default:
            break;
    }
    return opString;
}

- (NSString *)opSymbol
{
    return [[self utf8FromOperation:self.operation] copy];
}

- (NSArray *)plistValue
{
    if (self.value) {
        return @[[self stringFromOperation:self.operation], self.value];
    }
    return @[[self stringFromOperation:self.operation], self.rid.rid];
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    EXORpcPreprocessOperation *obj = object;
    if (self.value) {
        return self.operation == obj.operation && [self.value isEqualToNumber:obj.value];
    } else if (self.rid) {
        return self.operation == obj.operation && [self.rid isEqual:obj.rid];
    }
    return NO;
}

- (NSUInteger)hash
{
    return self.value.hash ^ self.rid.hash ^ self.operation;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (NSString *)description
{
    if (self.value) {
        return [NSString stringWithFormat:@"<%@: %p, Op: %@, Value: %@>", NSStringFromClass([self class]), self, [self stringFromOperation:self.operation], self.value];
    } else if (self.rid) {
        return [NSString stringWithFormat:@"<%@: %p, Op: %@, RID: %@>", NSStringFromClass([self class]), self, [self stringFromOperation:self.operation], self.rid];
    }
    return [NSString stringWithFormat:@"<%@: %p, Op: %@, INVALID>", NSStringFromClass([self class]), self, [self stringFromOperation:self.operation]];
}


@end
