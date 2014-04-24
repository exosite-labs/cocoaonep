//
//  EXORpcDataportResourceTest.m
//  CocoaOnePExample
//
//  Created by Michael Conrad Tadpol Tilstra on 4/24/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <EXORpc.h>

@interface EXORpcDataportResourceTest : XCTestCase

@end

@implementation EXORpcDataportResourceTest

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
    EXORpcDataportResource *dp;
    NSDictionary *result;

    dp = [EXORpcDataportResource dataportWithName:@"dogeton" format:EXORpcDataportFormatFloat];
    result = @{
        @"format": @"float",
        @"name": @"dogeton",
        @"preprocess": @[],
        @"public": @YES,
        @"retention":@{
            @"count": @"infinity",
            @"duration": @"infinity",
        },
        @"visibility": @"parent"
    };
    XCTAssertEqualObjects(result, [dp plistValue], @"Name and format");

    dp = [EXORpcDataportResource dataportWithName:@"dogeton" format:EXORpcDataportFormatInteger retention:[EXORpcResourceRetention retentionWithCount:@(10) duration:@(4)]];
    result = @{
               @"format": @"integer",
               @"name": @"dogeton",
               @"preprocess": @[],
               @"public": @YES,
               @"retention":@{
                       @"count": @(10),
                       @"duration": @(4),
                       },
               @"visibility": @"parent"
               };
    XCTAssertEqualObjects(result, [dp plistValue], @"Name, format and retention");

    dp = [EXORpcDataportResource dataportWithName:@"dogeton" meta:@"some meta" format:EXORpcDataportFormatString preprocess:@[@"booger"] subscribe:[EXORpcResourceID resourceIDAsSelf] retention:[EXORpcResourceRetention retentionWithCount:@(12) duration:@(90)]];
    result = @{
               @"format": @"string",
               @"name": @"dogeton",
               @"meta": @"some meta",
               @"preprocess": @[@"booger"],
               @"public": @YES,
               @"subscribe": @{@"alias": @""},
               @"retention":@{
                       @"count": @(12),
                       @"duration": @(90),
                       },
               @"visibility": @"parent"
               };
    XCTAssertEqualObjects(result, [dp plistValue], @"All options");

}

@end
