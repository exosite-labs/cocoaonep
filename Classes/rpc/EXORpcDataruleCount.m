//
//  EXORpcDataruleCount.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcDataruleCount.h"

@interface EXORpcDataruleCount ()
@property(nonatomic,assign) EXORpcDataruleComparison_t comparison;
@property(nonatomic,copy) NSNumber *constant;
@property(nonatomic,copy) NSNumber *count;
@property(nonatomic,copy) NSNumber *timeout;
@property(nonatomic,assign) BOOL repeat;
@end

@implementation EXORpcDataruleCount

+ (EXORpcDataruleCount *)dataruleCountWithCompare:(EXORpcDataruleComparison_t)comparison constant:(NSNumber *)constant count:(NSNumber*)count timeout:(NSNumber *)timeout repeat:(BOOL)repeat
{
    return [[EXORpcDataruleCount alloc] initWithCompare:comparison constant:constant count:count timeout:timeout repeat:repeat];
}

- (id)initWithCompare:(EXORpcDataruleComparison_t)comparison constant:(NSNumber *)constant count:(NSNumber*)count timeout:(NSNumber *)timeout repeat:(BOOL)repeat
{
    if (self = [super init]) {
        _comparison = comparison;
        _constant = [constant copy];
        _count = [count copy];
        _timeout = [timeout copy];
        _repeat = repeat;
    }
    return self;
}

- (id)init
{
    return nil;
}

- (NSDictionary *)plistValue
{
    return @{@"count": @{@"comparison": [self stringFromComparison:self.comparison], @"constant": self.constant, @"count": self.count, @"timeout": self.timeout, @"repeat": @(self.repeat)}};
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    EXORpcDataruleCount *obj = object;
    return (self.comparison == obj.comparison &&
            [self.constant isEqualToNumber:obj.constant] &&
            [self.timeout isEqualToNumber:obj.timeout] &&
            [self.count isEqualToNumber:obj.count] &&
            self.repeat == obj.repeat
            );
}

- (NSUInteger)hash
{
    return self.comparison ^ self.constant.hash ^ self.timeout.hash ^ self.count.hash ^ self.repeat;
}

@end
