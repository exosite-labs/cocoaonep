//
//  EXOOnepDataruleSimple.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepDataruleSimple.h"

@interface EXOOnepDataruleSimple ()
@property(nonatomic,assign) EXOOnepDataruleComparison_t comparison;
@property(nonatomic,copy) NSNumber *constant;
@property(nonatomic,assign) BOOL repeat;
@end

@implementation EXOOnepDataruleSimple

+ (EXOOnepDataruleSimple *)dataruleSimpleWithCompare:(EXOOnepDataruleComparison_t)comparison constant:(NSNumber *)constant repeat:(BOOL)repeat
{
    return [[EXOOnepDataruleSimple alloc] initWithCompare:comparison constant:constant repeat:repeat];
}

- (instancetype)initWithCompare:(EXOOnepDataruleComparison_t)comparison constant:(NSNumber *)constant repeat:(BOOL)repeat
{
    if (self = [super init]) {
        self.comparison = comparison;
        self.constant = constant;
        self.repeat = repeat;
    }
    return self;
}

- (id)init
{
    return nil;
}

- (NSDictionary *)plistValue
{
    return @{@"simple": @{@"comparison": [self stringFromComparison:self.comparison], @"constant": self.constant, @"repeat": self.repeat?@"true":@"false"}};
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    EXOOnepDataruleSimple *obj = object;
    return (self.comparison == obj.comparison &&
            [self.constant isEqualToNumber:obj.constant] &&
            self.repeat == obj.repeat
            );
}

- (NSUInteger)hash
{
    return self.comparison ^ self.constant.hash ^ self.repeat;
}

@end
