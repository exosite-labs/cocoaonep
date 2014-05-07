//
//  EXORpcRecordRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcRecordRequest.h"

@implementation EXORpcRecordRequest


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

@end
