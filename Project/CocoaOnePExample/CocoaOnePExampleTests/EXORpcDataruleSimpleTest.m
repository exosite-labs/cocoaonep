//
//  EXORpcDataruleSimpleTest.m
//  CocoaOnePExample
//
//  Created by Michael Conrad Tadpol Tilstra on 7/14/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EXORpc.h"

@interface EXORpcDataruleSimpleTest : XCTestCase

@end

@implementation EXORpcDataruleSimpleTest

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
    EXORpcDataruleSimple *ds;
    NSDictionary *result;

    ds = [EXORpcDataruleSimple dataruleSimpleWithCompare:EXORpcDataruleComparisonEqual constant:@(42) repeat:YES];
    result = @{@"simple": @{@"comparison": @"eq", @"constant": @(42), @"repeat": @YES}};
    XCTAssertEqualObjects([ds plistValue], result, @"");

    ds = [[EXORpcDataruleSimple alloc] initWithPList:@{@"comparison": @"eq", @"constant": @(42), @"repeat": @YES}];
    result = @{@"simple": @{@"comparison": @"eq", @"constant": @(42), @"repeat": @YES}};
    XCTAssertEqualObjects([ds plistValue], result, @"");
}

@end
