//
//  EXORpcDataruleDuration.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcDataruleDuration.h"

@interface EXORpcDataruleDuration ()
@property(nonatomic,assign) EXORpcDataruleComparison_t comparison;
@property(nonatomic,copy) NSNumber *constant;
@property(nonatomic,copy) NSNumber *timeout;
@property(nonatomic,assign) BOOL repeat;
@end

@implementation EXORpcDataruleDuration

+ (EXORpcDataruleDuration *)dataruleDurationWithCompare:(EXORpcDataruleComparison_t)comparison constant:(NSNumber *)constant timeout:(NSNumber *)timeout repeat:(BOOL)repeat
{
    return [[EXORpcDataruleDuration alloc] initWithCompare:comparison constant:constant timeout:timeout repeat:repeat];
}

- (id)initWithCompare:(EXORpcDataruleComparison_t)comparison constant:(NSNumber *)constant timeout:(NSNumber *)timeout repeat:(BOOL)repeat
{
    if (self = [super init]) {
        _comparison = comparison;
        _constant = [constant copy];
        _timeout = [timeout copy];
        _repeat = repeat;
    }
    return self;
}

- (instancetype)initWithPList:(NSDictionary *)plist
{
    return [self initWithCompare:[self comparisonFromString:plist[@"comparison"]] constant:plist[@"constant"] timeout:plist[@"timeout"] repeat:[plist[@"repeat"] boolValue]];
}

- (id)init
{
    return nil;
}

- (NSDictionary *)plistValue
{
    return @{@"duration": @{@"comparison": [self stringFromComparison:self.comparison], @"constant": self.constant, @"timeout": self.timeout, @"repeat": @(self.repeat)}};
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    EXORpcDataruleDuration *obj = object;
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
