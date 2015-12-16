//
//  EXORpcDataruleCountTest.m
//  CocoaOnePExample
//
//  Created by Michael Conrad Tadpol Tilstra on 7/14/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EXORpc.h"

@interface EXORpcDataruleCountTest : XCTestCase

@end

@implementation EXORpcDataruleCountTest

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
    EXORpcDataruleCount *dc;
    NSDictionary *result;

    dc = [EXORpcDataruleCount dataruleCountWithCompare:EXORpcDataruleComparisonEqual constant:@(42) count:@(5) timeout:@(60) repeat:NO];
    result = @{@"count": @{@"comparison": @"eq", @"constant": @(42), @"count": @(5), @"timeout": @(60), @"repeat": @NO}};
    XCTAssertEqualObjects([dc plistValue], result, @"");

    dc = [[EXORpcDataruleCount alloc] initWithPList:@{@"comparison": @"eq", @"constant": @(42), @"count": @(5), @"timeout": @(60), @"repeat": @NO}];
    result = @{@"count": @{@"comparison": @"eq", @"constant": @(42), @"count": @(5), @"timeout": @(60), @"repeat": @NO}};
    XCTAssertEqualObjects([dc plistValue], result, @"init with plist");

}

@end
