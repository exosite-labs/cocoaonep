//
//  EXODataruleTest.m
//  CocoaOnePExample
//
//  Created by Michael Conrad Tadpol Tilstra on 7/14/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <EXORpc.h>

@interface EXODataruleTest : XCTestCase

@end

@implementation EXODataruleTest

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
    EXORpcDatarule *dr = [EXORpcDatarule new];

    XCTAssertEqualObjects([dr stringFromComparison:EXORpcDataruleComparisonGreaterThan], @"gt", @"greater than");
    XCTAssertEqualObjects([dr stringFromComparison:EXORpcDataruleComparisonLessThan], @"lt", @"less than");
    XCTAssertEqualObjects([dr stringFromComparison:EXORpcDataruleComparisonEqual], @"eq", @"equal");
    XCTAssertEqualObjects([dr stringFromComparison:EXORpcDataruleComparisonGreaterOrEqual], @"geq", @"Greater than or Equal");
    XCTAssertEqualObjects([dr stringFromComparison:EXORpcDataruleComparisonLessOrEqual], @"leq", @"Less than or equal");
    XCTAssertEqualObjects([dr stringFromComparison:EXORpcDataruleComparisonNotEqual], @"neq", @"not equal");

    XCTAssertThrows([dr plistValue], @"Don't call this on base class.");
}

@end
