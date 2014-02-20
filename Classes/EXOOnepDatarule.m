//
//  EXOOnepDatarule.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepDatarule.h"

@implementation EXOOnepDatarule

- (NSString*)stringFromComparison:(EXOOnepDataruleComparison_t)comp
{
    NSString *ret;
    switch (comp) {
        default:
        case EXOOnepDataruleComparisonEqual:
            ret = @"eq";
            break;
        case EXOOnepDataruleComparisonGreaterOrEqual:
            ret = @"geq";
            break;
        case EXOOnepDataruleComparisonGreaterThan:
            ret = @"gt";
            break;
        case EXOOnepDataruleComparisonLessOrEqual:
            ret = @"leq";
            break;
        case EXOOnepDataruleComparisonLessThan:
            ret = @"lt";
            break;
        case EXOOnepDataruleComparisonNotEqual:
            ret = @"neq";
            break;
    }
    return ret;
}

- (NSDictionary *)asCall
{
    @throw @"Bad prgrammer";
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p, %@>", NSStringFromClass([self class]), self, [self asCall]];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

@end
