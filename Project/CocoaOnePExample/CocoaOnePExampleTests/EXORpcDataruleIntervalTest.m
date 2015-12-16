//
//  EXORpcDataruleIntervalTest.m
//  CocoaOnePExample
//
//  Created by Michael Conrad Tadpol Tilstra on 7/14/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EXORpc.h"

@interface EXORpcDataruleIntervalTest : XCTestCase

@end

@implementation EXORpcDataruleIntervalTest

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

- (void)testExample
{
    EXORpcDataruleInterval *di;
    NSDictionary *result;

    di = [EXORpcDataruleInterval dataruleIntervalWithComare:EXORpcDataruleComparisonEqual constant:@(42) timeout:@(60) repeat:NO];
    result = @{@"interval": @{@"comparison": @"eq", @"constant": @(42), @"timeout": @(60), @"repeat": @NO}};
    XCTAssertEqualObjects([di plistValue], result, @"");

    di = [[EXORpcDataruleInterval alloc] initWithPList:@{@"comparison": @"eq", @"constant": @(42), @"timeout": @(60), @"repeat": @NO}];
    result = @{@"interval": @{@"comparison": @"eq", @"constant": @(42), @"timeout": @(60), @"repeat": @NO}};
    XCTAssertEqualObjects([di plistValue], result, @"");
}

@end
