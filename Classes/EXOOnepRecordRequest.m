//
//  EXOOnepRecordRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepRecordRequest.h"

@implementation EXOOnepRecordRequest


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
    // Values array need to be checked and possbily have types changed.
    // It should be an array of arrays.  The inner ones should only have two elements; Date and Number, or Number and Number.
    NSMutableArray *nar = [NSMutableArray arrayWithCapacity:self.values.count];
    
    for (id item in self.values) {
        if ([item isKindOfClass:[NSArray class]]) {
            NSArray *ar = item;
            if (ar.count >= 2) {
                if ([ar[0] isKindOfClass:[NSDate class]] && [ar[1] isKindOfClass:[NSNumber class]]) {
                    NSDate *date = ar[0];
                    [nar addObject:@[@([date timeIntervalSince1970]), ar[1]]];
                } else if ([ar[0] isKindOfClass:[NSNumber class]] && [ar[1] isKindOfClass:[NSNumber class]]) {
                    [nar addObject:@[ar[0], ar[1]]];
                }
            }
        }
    }
    // TODO: ??? sliently drop bad entries? that's not very nice or helpful.  How to error this?
    
    return @{ @"procedure": @"record", @"arguments": @[[self.rid plistValue], nar, @{}]};
}

@end
