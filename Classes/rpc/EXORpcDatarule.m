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
