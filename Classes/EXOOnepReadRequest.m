//
//  EXOOnepReadRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepReadRequest.h"

@implementation EXOOnepReadRequest

- (id)init
{
    if (self = [super init]) {
        self.limit = 1; // By default just one
    }
    return self;
}

- (NSDictionary *)plistValue
{
    NSMutableDictionary *args = [NSMutableDictionary dictionary];
    if (self.starttime) {
        args[@"starttime"] = @([self.starttime timeIntervalSince1970]);
    }
    if (self.endtime) {
        args[@"endtime"] = @([self.endtime timeIntervalSince1970]);
    }
    args[@"sort"] = self.sortAscending?@"asc":@"desc";
    args[@"limit"] = @(self.limit);
    switch (self.selection) {
        default:
        case EXOOnepReadSelectionTypeAll:
            args[@"selection"] = @"all";
            break;
        case EXOOnepReadSelectionTypeAutoWindow:
            args[@"selection"] = @"autowindow";
            break;
        case EXOOnepReadSelectionTypeGivenWindow:
            args[@"selection"] = @"givenwindow";
            break;
    }
    return @{@"procedure": @"read", @"arguments": @[[self.rid plistValue], args]};
}

- (void)doResult:(NSDictionary *)result error:(NSError *)error
{
    if (self.complete) {
        NSError *err = [self errorFromStatus:result];
        if (err) {
            self.complete(nil, err);
        } else {
            NSArray *got = result[@"result"];
            NSMutableArray *given = [NSMutableArray arrayWithCapacity:got.count];
            for (NSArray *item in got) {
                // item[0] is timestamp
                // item[1] is value
                NSDate *when = [NSDate dateWithTimeIntervalSince1970:[item[0] longLongValue]];
                // TODO: detect and convert boolean values.
                [given addObject:@[when, item[1]]];
            }
            self.complete(given, nil);
        }
    }
}

@end
