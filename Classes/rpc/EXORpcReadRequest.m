//
//  EXORpcReadRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcReadRequest.h"

@interface EXORpcReadRequest ()
@property(nonatomic,strong) NSDate *starttime;
@property(nonatomic,strong) NSDate *endtime;
@property(nonatomic,assign) BOOL sortAscending;
@property(nonatomic,assign) NSUInteger limit;
@property(nonatomic,assign) EXORpcReadSelectionType_t selection;
@property(nonatomic,copy) EXORpcReadRequestComplete complete;
@end

@implementation EXORpcReadRequest

+ (EXORpcReadRequest *)readWithRID:(EXORpcResourceID *)rid complete:(EXORpcReadRequestComplete)complete
{
    return [[EXORpcReadRequest alloc] initWithRID:rid startTime:nil endTime:nil ascending:NO limit:1 selection:EXORpcReadSelectionTypeAll complete:complete];
}

+ (EXORpcReadRequest *)readWithRID:(EXORpcResourceID *)rid startTime:(NSDate *)starttime endTime:(NSDate *)endtime ascending:(BOOL)ascending limit:(NSUInteger)limit selection:(EXORpcReadSelectionType_t)selection complete:(EXORpcReadRequestComplete)complete
{
    return [[EXORpcReadRequest alloc] initWithRID:rid startTime:starttime endTime:endtime ascending:ascending limit:limit selection:selection complete:complete];
}

- (id)initWithRID:(EXORpcResourceID *)rid startTime:(NSDate *)starttime endTime:(NSDate *)endtime ascending:(BOOL)ascending limit:(NSUInteger)limit selection:(EXORpcReadSelectionType_t)selection complete:(EXORpcReadRequestComplete)complete
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
        args[@"starttime"] = @((long long)[self.starttime timeIntervalSince1970]);
    }
    if (self.endtime) {
        args[@"endtime"] = @((long long)[self.endtime timeIntervalSince1970]);
    }
    args[@"sort"] = self.sortAscending?@"asc":@"desc";
    args[@"limit"] = @(self.limit);
    switch (self.selection) {
        default:
        case EXORpcReadSelectionTypeAll:
            args[@"selection"] = @"all";
            break;
        case EXORpcReadSelectionTypeAutoWindow:
            args[@"selection"] = @"autowindow";
            break;
        case EXORpcReadSelectionTypeGivenWindow:
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

                EXORpcValue *rval;
                id value = item[1];
                if ([value isKindOfClass:[NSString class]]) {
                    rval = [EXORpcValue valueWithDate:when string:value];
                } else if ([value isKindOfClass:[NSNumber class]]) {
                    rval = [EXORpcValue valueWithDate:when number:value];
                } else {
                    rval = [EXORpcValue valueWithDate:when string:[value description]];
                }
                [given addObject:rval];
            }
            self.complete([given copy], nil);
        }
    }
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    EXORpcReadRequest *obj = (EXORpcReadRequest *)object;
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
