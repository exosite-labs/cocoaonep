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
