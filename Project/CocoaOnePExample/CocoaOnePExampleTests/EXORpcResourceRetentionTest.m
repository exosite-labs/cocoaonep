//
//  EXORpcResourceRetentionTest.m
//  CocoaOnePExample
//
//  Created by Michael Conrad Tadpol Tilstra on 4/24/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EXORpc.h"

@interface EXORpcResourceRetentionTest : XCTestCase

@end

@implementation EXORpcResourceRetentionTest

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
    EXORpcResourceRetention *reten;
    NSDictionary *result;

    reten = [EXORpcResourceRetention retentionWithCount:@(10) duration:@(10)];
    result = @{@"count": @(10), @"duration": @(10)};
    XCTAssertEqualObjects(result, [reten plistValue], @"With two numbers.");

    reten = [EXORpcResourceRetention new];
    result = @{@"count": @"infinity", @"duration": @"infinity"};
    XCTAssertEqualObjects(result, [reten plistValue], @"With infinity");

    reten = [EXORpcResourceRetention retentionWithCount:nil duration:nil];
    result = @{@"count": @"infinity", @"duration": @"infinity"};
    XCTAssertEqualObjects(result, [reten plistValue], @"Infinity another way.");

    reten = [EXORpcResourceRetention retentionWithCount:@(42) duration:nil];
    result = @{@"count": @(42), @"duration": @"infinity"};
    XCTAssertEqualObjects(result, [reten plistValue], @"Mixed infinity and number.");

    reten = [EXORpcResourceRetention retentionWithCount:nil duration:@(169)];
    result = @{@"count": @"infinity", @"duration": @(169)};
    XCTAssertEqualObjects(result, [reten plistValue], @"Mixed infinity and number.");

    reten = [[EXORpcResourceRetention alloc] initWithPList:@{@"count": @"infinity", @"duration": @(169)}];
    result = @{@"count": @"infinity", @"duration": @(169)};
    XCTAssertEqualObjects(result, [reten plistValue], @"Initialized from a property list");

    reten = [[EXORpcResourceRetention alloc] initWithPList:@{@"duration": @(169)}];
    result = @{@"count": @"infinity", @"duration": @(169)};
    XCTAssertEqualObjects(result, [reten plistValue], @"Initialized from a property list");

}

@end
