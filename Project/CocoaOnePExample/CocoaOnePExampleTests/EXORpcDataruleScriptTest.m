//
//  EXORpcDataruleScriptTest.m
//  CocoaOnePExample
//
//  Created by Michael Conrad Tadpol Tilstra on 7/14/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <EXORpc.h>

@interface EXORpcDataruleScriptTest : XCTestCase

@end

@implementation EXORpcDataruleScriptTest

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
    EXORpcDataruleScript *ds;
    NSDictionary *result;

    ds = [EXORpcDataruleScript dataruleScriptWithScript:@"-- Not for real\n"];
    result = @{@"script": @"-- Not for real\n"};
    XCTAssertEqualObjects([ds plistValue], result, @"");
}

@end
