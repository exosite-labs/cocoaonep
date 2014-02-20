//
//  EXOOnepDataruleDuration.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepDataruleDuration.h"

@interface EXOOnepDataruleDuration ()
@property(nonatomic,assign) EXOOnepDataruleComparison_t comparison;
@property(nonatomic,copy) NSNumber *constant;
@property(nonatomic,copy) NSNumber *timeout;
@property(nonatomic,assign) BOOL repeat;
@end

@implementation EXOOnepDataruleDuration

+ (EXOOnepDataruleDuration *)dataruleDurationWithCompare:(EXOOnepDataruleComparison_t)comparison constant:(NSNumber *)constant timeout:(NSNumber *)timeout repeat:(BOOL)repeat
{
    return [[EXOOnepDataruleDuration alloc] initWithCompare:comparison constant:constant timeout:timeout repeat:repeat];
}

- (id)initWithCompare:(EXOOnepDataruleComparison_t)comparison constant:(NSNumber *)constant timeout:(NSNumber *)timeout repeat:(BOOL)repeat
{
    if (self = [super init]) {
        self.comparison = comparison;
        self.constant = constant;
        self.timeout = timeout;
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
    return @{@"duration": @{@"comparison": [self stringFromComparison:self.comparison], @"constant": self.constant, @"timeout": self.timeout, @"repeat": self.repeat?@"true":@"false"}};
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    EXOOnepDataruleDuration *obj = object;
    return (self.comparison == obj.comparison &&
            [self.constant isEqualToNumber:obj.constant] &&
            [self.timeout isEqualToNumber:obj.timeout] &&
            self.repeat == obj.repeat
            );
}

- (NSUInteger)hash
{
    return self.comparison ^ self.constant.hash ^ self.timeout.hash ^ self.repeat;
}

@end
