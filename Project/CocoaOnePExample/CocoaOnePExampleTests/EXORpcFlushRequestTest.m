//
//  EXORpcFlushRequestTest.m
//  CocoaOnePExample
//
//  Created by Michael Conrad Tadpol Tilstra on 5/29/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <EXORpc.h>

@interface EXORpcFlushRequestTest : XCTestCase

@end

@implementation EXORpcFlushRequestTest

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
    EXORpcFlushRequest *flush;
    NSDictionary *result;
    EXORpcResourceID *rid = [EXORpcResourceID resourceIDAsSelf];
    NSDate *nt = [NSDate dateWithTimeIntervalSince1970:123456];
    NSDate *ot = [NSDate dateWithTimeIntervalSince1970:987654321];

    flush = [EXORpcFlushRequest flushRID:rid newerThan:nil olderThan:nil complete:nil];
    result = @{ @"procedure": @"flush", @"arguments": @[@{@"alias": @""}, @{}]};
    XCTAssertEqualObjects([flush plistValue], result, @"No constraints. delete everything");

    flush = [EXORpcFlushRequest flushRID:rid newerThan:nt olderThan:nil complete:nil];
    result = @{ @"procedure": @"flush", @"arguments": @[@{@"alias": @""}, @{@"newerthan": @(123456)}]};
    XCTAssertEqualObjects([flush plistValue], result, @"No constraints. delete everything");

    flush = [EXORpcFlushRequest flushRID:rid newerThan:nil olderThan:ot complete:nil];
    result = @{ @"procedure": @"flush", @"arguments": @[@{@"alias": @""}, @{@"olderthan": @(987654321)}]};
    XCTAssertEqualObjects([flush plistValue], result, @"No constraints. delete everything");

    flush = [EXORpcFlushRequest flushRID:rid newerThan:nt olderThan:ot complete:nil];
    result = @{ @"procedure": @"flush", @"arguments": @[@{@"alias": @""}, @{@"newerthan": @(123456), @"olderthan": @(987654321)}]};
    XCTAssertEqualObjects([flush plistValue], result, @"No constraints. delete everything");
}

@end
