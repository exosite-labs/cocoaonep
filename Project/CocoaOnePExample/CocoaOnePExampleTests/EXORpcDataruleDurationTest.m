//
//  EXORpcDataruleDurationTest.m
//  CocoaOnePExample
//
//  Created by Michael Conrad Tadpol Tilstra on 7/14/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <EXORpc.h>

@interface EXORpcDataruleDurationTest : XCTestCase

@end

@implementation EXORpcDataruleDurationTest

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
    EXORpcDataruleDuration *dd;
    NSDictionary *result;

    dd = [EXORpcDataruleDuration dataruleDurationWithCompare:EXORpcDataruleComparisonEqual constant:@(42) timeout:@(60) repeat:YES];
    result = @{@"duration": @{@"comparison": @"eq", @"constant": @(42), @"timeout": @(60), @"repeat": @YES}};
    XCTAssertEqualObjects([dd plistValue], result, @"");
    
}

@end
