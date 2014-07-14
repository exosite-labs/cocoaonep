//
//  EXORpcDatarule.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcDatarule.h"

@implementation EXORpcDatarule

- (NSString*)stringFromComparison:(EXORpcDataruleComparison_t)comp
{
    NSString *ret;
    switch (comp) {
        default:
        case EXORpcDataruleComparisonEqual:
            ret = @"eq";
            break;
        case EXORpcDataruleComparisonGreaterOrEqual:
            ret = @"geq";
            break;
        case EXORpcDataruleComparisonGreaterThan:
            ret = @"gt";
            break;
        case EXORpcDataruleComparisonLessOrEqual:
            ret = @"leq";
            break;
        case EXORpcDataruleComparisonLessThan:
            ret = @"lt";
            break;
        case EXORpcDataruleComparisonNotEqual:
            ret = @"neq";
            break;
    }
    return ret;
}

- (EXORpcDataruleComparison_t)comparisonFromString:(NSString*)str
{
    if ([str isEqualToString:@"eq"]) {
        return EXORpcDataruleComparisonEqual;
    } else if ([str isEqualToString:@"gt"]) {
        return EXORpcDataruleComparisonGreaterThan;
    } else if ([str isEqualToString:@"geq"]) {
        return EXORpcDataruleComparisonGreaterOrEqual;
    } else if ([str isEqualToString:@"leq"]) {
        return EXORpcDataruleComparisonLessOrEqual;
    } else if ([str isEqualToString:@"lt"]) {
        return EXORpcDataruleComparisonLessThan;
    } else if ([str isEqualToString:@"neq"]) {
        return EXORpcDataruleComparisonNotEqual;
    }
    return EXORpcDataruleComparisonEqual;
}

- (NSDictionary *)plistValue
{
    @throw @"Bad prgrammer";
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p, %@>", NSStringFromClass([self class]), self, [self plistValue]];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

@end
