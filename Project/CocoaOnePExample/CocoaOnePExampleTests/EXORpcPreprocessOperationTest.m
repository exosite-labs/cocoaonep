//
//  EXORpcPreprocessOperationTest.m
//  CocoaOnePExample
//
//  Created by Michael Conrad Tadpol Tilstra on 6/19/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <EXORpc.h>

@interface EXORpcPreprocessOperationTest : XCTestCase

@end

@implementation EXORpcPreprocessOperationTest

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
    EXORpcPreprocessOperation *ppo;
    NSArray *result;

    ppo = [EXORpcPreprocessOperation preprocessOperation:EXORpcPreprocessOperation_Add value:@(42)];
    result = @[@"add", @(42)];
    XCTAssertEqualObjects([ppo plistValue], result, @"add");

    ppo = [EXORpcPreprocessOperation preprocessOperation:EXORpcPreprocessOperation_Subtract value:@(42)];
    result = @[@"sub", @(42)];
    XCTAssertEqualObjects([ppo plistValue], result, @"subtract");

    ppo = [EXORpcPreprocessOperation preprocessOperation:EXORpcPreprocessOperation_Multiply value:@(42)];
    result = @[@"mul", @(42)];
    XCTAssertEqualObjects([ppo plistValue], result, @"multiply");

    ppo = [EXORpcPreprocessOperation preprocessOperation:EXORpcPreprocessOperation_Divide value:@(42)];
    result = @[@"div", @(42)];
    XCTAssertEqualObjects([ppo plistValue], result, @"divide");

    ppo = [EXORpcPreprocessOperation preprocessOperation:EXORpcPreprocessOperation_Modulo value:@(42)];
    result = @[@"mod", @(42)];
    XCTAssertEqualObjects([ppo plistValue], result, @"modulo");

    ppo = [EXORpcPreprocessOperation preprocessOperation:EXORpcPreprocessOperation_GreaterThan value:@(42)];
    result = @[@"gt", @(42)];
    XCTAssertEqualObjects([ppo plistValue], result, @"greater than");

    ppo = [EXORpcPreprocessOperation preprocessOperation:EXORpcPreprocessOperation_GreaterThanOrEqual value:@(42)];
    result = @[@"geq", @(42)];
    XCTAssertEqualObjects([ppo plistValue], result, @"greater than or equal to");

    ppo = [EXORpcPreprocessOperation preprocessOperation:EXORpcPreprocessOperation_LessThan value:@(42)];
    result = @[@"lt", @(42)];
    XCTAssertEqualObjects([ppo plistValue], result, @"less than");

    ppo = [EXORpcPreprocessOperation preprocessOperation:EXORpcPreprocessOperation_LessThanOrEqual value:@(42)];
    result = @[@"leq", @(42)];
    XCTAssertEqualObjects([ppo plistValue], result, @"less than or equal to");

    ppo = [EXORpcPreprocessOperation preprocessOperation:EXORpcPreprocessOperation_Equal value:@(42)];
    result = @[@"eq", @(42)];
    XCTAssertEqualObjects([ppo plistValue], result, @"equal");

    ppo = [EXORpcPreprocessOperation preprocessOperation:EXORpcPreprocessOperation_NotEqual value:@(42)];
    result = @[@"neq", @(42)];
    XCTAssertEqualObjects([ppo plistValue], result, @"not equal to");

    ppo = [EXORpcPreprocessOperation preprocessOperation:EXORpcPreprocessOperation_Value value:@(42)];
    result = @[@"value", @(42)];
    XCTAssertEqualObjects([ppo plistValue], result, @"value");


    ppo = [[EXORpcPreprocessOperation alloc] initWithPList:@[@"eq", @(42)]];
    result = @[@"eq", @(42)];
    XCTAssertEqualObjects([ppo plistValue], result, @"init with plist");
}

@end
