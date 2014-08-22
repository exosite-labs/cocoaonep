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
@end

@implementation EXORpcPreprocessOperation

+ (EXORpcPreprocessOperation *)preprocessOperation:(EXORpcPreprocessOperation_t)operation value:(NSNumber *)value
{
    return [[EXORpcPreprocessOperation alloc] initWithOperation:operation value:value];
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

    return [self initWithOperation:op value:plist[1]];
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
        case EXORpcPreprocessOperation_Value: opString = @"⇶"; break;
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
    return @[[self stringFromOperation:self.operation], self.value];
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    return self.operation == [object operation] && [self.value isEqual:[(EXORpcPreprocessOperation*)object value]];
}

- (NSUInteger)hash
{
    return self.value.hash ^ self.operation;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p, Op: %@, Value: %@>", NSStringFromClass([self class]), self, [self stringFromOperation:self.operation], self.value];
}


@end
