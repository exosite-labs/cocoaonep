//
//  EXORpcReadRequestTest.m
//  CocoaOnePExample
//
//  Created by Michael Conrad Tadpol Tilstra on 6/9/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EXORpc.h"

@interface EXORpcReadRequestTest : XCTestCase

@end

@implementation EXORpcReadRequestTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAllocAndInit
{
    EXORpcReadRequest *read;
    NSDictionary *result;
    EXORpcResourceID *rid = [EXORpcResourceID resourceIDAsSelf];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:42];

    read = [EXORpcReadRequest readWithRID:rid complete:^(id a, id b){}];
    result = @{@"procedure": @"read", @"arguments": @[@{@"alias": @""}, @{@"sort":@"desc", @"limit": @(1), @"selection": @"all"}]};
    XCTAssertEqualObjects([read plistValue], result, @"simple read");

    read = [EXORpcReadRequest readWithRID:rid startTime:nil endTime:nil ascending:NO limit:1 selection:EXORpcReadSelectionTypeAutoWindow complete:^(id a, id b){}];
    result = @{@"procedure": @"read", @"arguments": @[@{@"alias": @""}, @{@"sort":@"desc", @"limit": @(1), @"selection": @"autowindow"}]};
    XCTAssertEqualObjects([read plistValue], result, @"auto selection");

    read = [EXORpcReadRequest readWithRID:rid startTime:nil endTime:nil ascending:YES limit:1 selection:EXORpcReadSelectionTypeAutoWindow complete:^(id a, id b){}];
    result = @{@"procedure": @"read", @"arguments": @[@{@"alias": @""}, @{@"sort":@"asc", @"limit": @(1), @"selection": @"autowindow"}]};
    XCTAssertEqualObjects([read plistValue], result, @"ascending selection");

    read = [EXORpcReadRequest readWithRID:rid startTime:nil endTime:nil ascending:NO limit:1 selection:EXORpcReadSelectionTypeGivenWindow complete:^(id a, id b){}];
    result = @{@"procedure": @"read", @"arguments": @[@{@"alias": @""}, @{@"sort":@"desc", @"limit": @(1), @"selection": @"givenwindow"}]};
    XCTAssertEqualObjects([read plistValue], result, @"given selection");

    read = [EXORpcReadRequest readWithRID:rid startTime:nil endTime:nil ascending:NO limit:212 selection:EXORpcReadSelectionTypeAll complete:^(id a, id b){}];
    result = @{@"procedure": @"read", @"arguments": @[@{@"alias": @""}, @{@"sort":@"desc", @"limit": @(212), @"selection": @"all"}]};
    XCTAssertEqualObjects([read plistValue], result, @"limit check");

    read = [EXORpcReadRequest readWithRID:rid startTime:date endTime:nil ascending:NO limit:1 selection:EXORpcReadSelectionTypeAll complete:^(id a, id b){}];
    result = @{@"procedure": @"read", @"arguments": @[@{@"alias": @""}, @{@"starttime": @(42), @"sort":@"desc", @"limit": @(1), @"selection": @"all"}]};
    XCTAssertEqualObjects([read plistValue], result, @"Set start time");

    read = [EXORpcReadRequest readWithRID:rid startTime:nil endTime:date ascending:NO limit:1 selection:EXORpcReadSelectionTypeAll complete:^(id a, id b){}];
    result = @{@"procedure": @"read", @"arguments": @[@{@"alias": @""}, @{@"endtime": @(42), @"sort":@"desc", @"limit": @(1), @"selection": @"all"}]};
    XCTAssertEqualObjects([read plistValue], result, @"Set end time");


}

@end
