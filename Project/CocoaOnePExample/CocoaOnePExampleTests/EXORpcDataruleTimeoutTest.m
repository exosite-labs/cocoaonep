//
//  EXORpcDataruleTimeoutTest.m
//  CocoaOnePExample
//
//  Created by Michael Conrad Tadpol Tilstra on 7/14/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <EXORpc.h>

@interface EXORpcDataruleTimeoutTest : XCTestCase

@end

@implementation EXORpcDataruleTimeoutTest

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
    EXORpcDataruleTimeout *dt;
    NSDictionary *result;

    dt = [EXORpcDataruleTimeout dataruleTimeoutWithTimeout:@(42) repeat:NO];
    result = @{@"timeout": @{@"timeout": @(42), @"repeat": @NO}};
    XCTAssertEqualObjects([dt plistValue], result, @"");

    dt = [[EXORpcDataruleTimeout alloc] initWithPList:@{@"timeout": @(42), @"repeat": @NO}];
    result = @{@"timeout": @{@"timeout": @(42), @"repeat": @NO}};
    XCTAssertEqualObjects([dt plistValue], result, @"");
}

@end
