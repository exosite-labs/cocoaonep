//
//  EXORpcDataruleSimple.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcDataruleSimple.h"

@interface EXORpcDataruleSimple ()
@property(nonatomic,assign) EXORpcDataruleComparison_t comparison;
@property(nonatomic,copy) NSNumber *constant;
@property(nonatomic,assign) BOOL repeat;
@end

@implementation EXORpcDataruleSimple

+ (EXORpcDataruleSimple *)dataruleSimpleWithCompare:(EXORpcDataruleComparison_t)comparison constant:(NSNumber *)constant repeat:(BOOL)repeat
{
    return [[EXORpcDataruleSimple alloc] initWithCompare:comparison constant:constant repeat:repeat];
}

- (instancetype)initWithCompare:(EXORpcDataruleComparison_t)comparison constant:(NSNumber *)constant repeat:(BOOL)repeat
{
    if (self = [super init]) {
        _comparison = comparison;
        _constant = [constant copy];
        _repeat = repeat;
    }
    return self;
}

- (instancetype)initWithPList:(NSDictionary *)plist
{
    return [self initWithCompare:[self comparisonFromString:plist[@"comparison"]] constant:plist[@"constant"] repeat:[plist[@"repeat"] boolValue]];
}

- (id)init
{
    return nil;
}

- (NSDictionary *)plistValue
{
    return @{@"simple": @{@"comparison": [self stringFromComparison:self.comparison], @"constant": self.constant, @"repeat": @(self.repeat)}};
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    EXORpcDataruleSimple *obj = object;
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
