//
//  EXOOnepReadRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepReadRequest.h"

@interface EXOOnepReadRequest ()
@property(nonatomic,strong) NSDate *starttime;
@property(nonatomic,strong) NSDate *endtime;
@property(nonatomic,assign) BOOL sortAscending;
@property(nonatomic,assign) NSUInteger limit;
@property(nonatomic,assign) EXOOnepReadSelectionType_t selection;
@property(nonatomic,copy) EXOOnepReadRequestComplete complete;
@end

@implementation EXOOnepReadRequest

+ (EXOOnepReadRequest *)readWithRID:(EXOOnepResourceID *)rid complete:(EXOOnepReadRequestComplete)complete
{
    return [[EXOOnepReadRequest alloc] initWithRID:rid startTime:nil endTime:nil ascending:YES limit:1 selection:EXOOnepReadSelectionTypeAll complete:complete];
}

+ (EXOOnepReadRequest *)readWithRID:(EXOOnepResourceID *)rid startTime:(NSDate *)starttime endTime:(NSDate *)endtime ascending:(BOOL)ascending limit:(NSUInteger)limit selection:(EXOOnepReadSelectionType_t)selection complete:(EXOOnepReadRequestComplete)complete
{
    return [[EXOOnepReadRequest alloc] initWithRID:rid startTime:starttime endTime:endtime ascending:ascending limit:limit selection:selection complete:complete];
}

- (id)initWithRID:(EXOOnepResourceID *)rid startTime:(NSDate *)starttime endTime:(NSDate *)endtime ascending:(BOOL)ascending limit:(NSUInteger)limit selection:(EXOOnepReadSelectionType_t)selection complete:(EXOOnepReadRequestComplete)complete
{
    if (self = [super init]) {
        self.rid = rid;
        self.starttime = starttime;
        self.endtime = endtime;
        self.sortAscending = ascending;
        self.limit = limit;
        self.selection = selection;
        self.complete = complete;
    }
    return self;
}

- (id)init
{
    return nil;
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
    return @{@"procedure": @"read", @"arguments": @[[self.rid plistValue], [args copy]]};
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

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    EXOOnepReadRequest *obj = (EXOOnepReadRequest *)object;
    return ([self.starttime isEqualToDate:obj.starttime] &&
            [self.endtime isEqualToDate:obj.endtime] &&
            self.sortAscending == obj.sortAscending &&
            self.limit == obj.limit &&
            self.selection == obj.selection);
    
}

- (NSUInteger)hash
{
    return self.starttime.hash ^ self.endtime.hash ^ self.sortAscending ^ self.limit ^ self.selection;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

@end
