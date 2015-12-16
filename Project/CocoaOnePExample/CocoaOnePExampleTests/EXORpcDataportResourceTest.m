//
//  EXORpcDataportResourceTest.m
//  CocoaOnePExample
//
//  Created by Michael Conrad Tadpol Tilstra on 4/24/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EXORpc.h"

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
        @"visibility": @"parent"
    };
    XCTAssertEqualObjects(result, [dp plistValue], @"Name and format");

    dp = [EXORpcDataportResource dataportWithName:@"dogeton" format:EXORpcDataportFormatInteger retention:[EXORpcResourceRetention retentionWithCount:@(10) duration:@(4)]];
    result = @{
               @"format": @"integer",
               @"name": @"dogeton",
               @"retention":@{
                       @"count": @(10),
                       @"duration": @(4),
                       },
               @"visibility": @"parent"
               };
    XCTAssertEqualObjects(result, [dp plistValue], @"Name, format and retention");

    EXORpcPreprocessOperation *ppo = [EXORpcPreprocessOperation preprocessOperation:EXORpcPreprocessOperation_Add value:@(42)];
    dp = [EXORpcDataportResource dataportWithName:@"dogeton" meta:@"some meta" public:NO format:EXORpcDataportFormatString preprocess:@[ppo] subscribe:[EXORpcResourceID resourceIDAsSelf] retention:[EXORpcResourceRetention retentionWithCount:@(12) duration:@(90)]];
    result = @{
               @"format": @"string",
               @"name": @"dogeton",
               @"meta": @"some meta",
               @"preprocess": @[@[@"add", @(42)]],
               @"subscribe": @{@"alias": @""},
               @"retention":@{
                       @"count": @(12),
                       @"duration": @(90),
                       },
               @"visibility": @"parent"
               };
    XCTAssertEqualObjects(result, [dp plistValue], @"All options");

    ppo = [EXORpcPreprocessOperation preprocessOperation:EXORpcPreprocessOperation_Add value:@(42)];
    dp = [EXORpcDataportResource dataportWithName:@"dogeton" meta:@"some meta" public:NO format:EXORpcDataportFormatString preprocess:@[ppo] subscribe:[EXORpcResourceID invalid] retention:[EXORpcResourceRetention retentionWithCount:@(12) duration:@(90)]];
    result = @{
               @"format": @"string",
               @"name": @"dogeton",
               @"meta": @"some meta",
               @"preprocess": @[@[@"add", @(42)]],
               @"subscribe": [NSNull null],
               @"retention":@{
                       @"count": @(12),
                       @"duration": @(90),
                       },
               @"visibility": @"parent"
               };
    XCTAssertEqualObjects(result, [dp plistValue], @"All options; clear subscription.");

    result = @{
               @"format": @"string",
               @"name": @"dogeton",
               @"meta": @"some meta",
               @"preprocess": @[@[@"add", @(42)]],
               @"subscribe": @"7de6dd91901d3f486829ef6feb9cb6c8094e26ed",
               @"retention":@{
                       @"count": @(12),
                       @"duration": @(90),
                       },
               @"visibility": @"parent"
               };
    dp = [[EXORpcDataportResource alloc] initWithPList:result];
    XCTAssertEqualObjects(result, [dp plistValue], @"Initialize from plist.");

    result = @{
               @"format": @"string",
               @"name": @"dogeton",
               @"meta": @"some meta",
               @"preprocess": @[],
               @"subscribe": [NSNull null],
               @"retention":@{
                       @"count": @(12),
                       @"duration": @(90),
                       },
               @"visibility": @"parent"
               };
    dp = [[EXORpcDataportResource alloc] initWithPList:result];
    result = @{
               @"format": @"string",
               @"name": @"dogeton",
               @"meta": @"some meta",
               @"preprocess": @[],
               @"retention":@{
                       @"count": @(12),
                       @"duration": @(90),
                       },
               @"visibility": @"parent"
               };
    XCTAssertEqualObjects(result, [dp plistValue], @"Initialize from plist.");


}

@end
