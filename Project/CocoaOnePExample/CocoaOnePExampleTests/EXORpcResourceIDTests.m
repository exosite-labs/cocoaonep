//
//  EXORpcResourceIDTests.m
//  CocoaOnePExample
//
//  Created by Michael Conrad Tadpol Tilstra on 4/8/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EXORpc.h"

@interface EXORpcResourceIDTests : XCTestCase

@end

@implementation EXORpcResourceIDTests

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
    EXORpcResourceID *rid;

    rid = [EXORpcResourceID resourceIDAsSelf];
    XCTAssertEqualObjects(@{@"alias": @""}, [rid plistValue], @"Self resource ID");

    rid = [EXORpcResourceID resourceIDByAlias:@"an_anliasResource"];
    XCTAssertEqualObjects(@{@"alias": @"an_anliasResource"}, [rid plistValue], @"Alias resource ID");

    rid = [EXORpcResourceID resourceIDByRID:@"34eaae237988167d90bfc2ffeb666daaaaaaaaaa"];
    XCTAssertEqualObjects(@"34eaae237988167d90bfc2ffeb666daaaaaaaaaa", [rid plistValue], @"RID string resource ID");

    rid = [EXORpcResourceID invalid];
    XCTAssertEqualObjects([NSNull null], [rid plistValue], @"Invalid RID");
}

@end
