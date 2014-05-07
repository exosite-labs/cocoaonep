//
//  EXORpcValueTest.m
//  CocoaOnePExample
//
//  Created by Michael Conrad Tadpol Tilstra on 5/6/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EXORpc.h"

@interface EXORpcValueTest : XCTestCase

@end

@implementation EXORpcValueTest

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
    EXORpcValue *value;
    NSArray *result;

    value = [EXORpcValue valueWithDate:[NSDate dateWithTimeIntervalSince1970:42] number:@(123456)];
    XCTAssertEqualObjects(value.when, [NSDate dateWithTimeIntervalSince1970:42], @"Check date");
    XCTAssertEqualObjects(value.numberValue, @(123456), @"Check number");
    XCTAssertEqualObjects(value.stringValue, @"123456", @"Check number");
    result = @[@(42), @(123456)];
    XCTAssertEqualObjects([value plistValue], result, @"Check plist");

    value = [EXORpcValue valueWithDate:[NSDate dateWithTimeIntervalSince1970:42] string:@"Fiddly pop"];
    XCTAssertEqualObjects(value.when, [NSDate dateWithTimeIntervalSince1970:42], @"Check date");
    XCTAssertEqualObjects(value.stringValue, @"Fiddly pop", @"Check number");
    XCTAssertEqualObjects(value.numberValue, nil, @"Check number");
    result = @[@(42), @"Fiddly pop"];
    XCTAssertEqualObjects([value plistValue], result, @"Check plist");

}

@end
