//
//  EXORpcRecordRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcRecordRequest.h"

@interface EXORpcRecordRequest ()
@property(strong,nonatomic) NSArray *values;  // Array of EXORpcValues
@property(copy,nonatomic) EXORpcRequestComplete complete;
@end

@implementation EXORpcRecordRequest

+ (EXORpcRecordRequest *)recordWithRID:(EXORpcResourceID *)rid values:(NSArray *)values complete:(EXORpcRequestComplete)complete
{
    return [[EXORpcRecordRequest alloc] initWithRID:rid values:values complete:complete];
}

- (instancetype)initWithRID:(EXORpcResourceID *)rid values:(NSArray *)values complete:(EXORpcRequestComplete)complete
{
    if (self = [super initWithRID:rid]) {
        _values = [values copy];
        _complete = [complete copy];
    }
    return self;
}

- (id)init
{
    return nil;
}

- (void)doResult:(NSDictionary *)result error:(NSError *)error
{
    if (self.complete) {
        NSError *err = [self errorFromStatus:result];
        if (err) {
            self.complete(err);
        } else {
            self.complete(nil);
        }
    }
}

- (NSDictionary *)plistValue
{
    // Values is an array of EXORpcValues
    NSMutableArray *nar = [NSMutableArray arrayWithCapacity:self.values.count];

    for (EXORpcValue *item in self.values) {
        [nar addObject:[item plistValue]];
    }

    return @{ @"procedure": @"record", @"arguments": @[[self.rid plistValue], [nar copy], @{}]};
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    return [self.rid isEqual:[object rid]] && [self.values isEqualToArray:[object values]];
}

- (NSUInteger)hash
{
    return self.rid.hash ^ self.values.hash;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

@end
