//
//  EXORpcInfoRequestTest.m
//  CocoaOnePExample
//
//  Created by Michael Conrad Tadpol Tilstra on 5/29/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <EXORpc.h>

@interface EXORpcInfoRequestTest : XCTestCase

@end

@implementation EXORpcInfoRequestTest

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
    EXORpcInfoRequest *info;
    NSDictionary *result;
    EXORpcResourceID *rid = [EXORpcResourceID resourceIDAsSelf];

    info = [EXORpcInfoRequest infoByRID:rid types:EXORpcInfoRequestTypeAll complete:nil];
    result = @{@"procedure": @"info", @"arguments": @[@{@"alias": @""}, @{}]};
    XCTAssertEqualObjects([info plistValue], result, @"All info");

    info = [EXORpcInfoRequest infoByRID:rid types:EXORpcInfoRequestTypeAliases complete:nil];
    result = @{@"procedure": @"info", @"arguments": @[@{@"alias": @""}, @{@"aliases": @YES}]};
    XCTAssertEqualObjects([info plistValue], result, @"Alias info");

    info = [EXORpcInfoRequest infoByRID:rid types:EXORpcInfoRequestTypeBasic complete:nil];
    result = @{@"procedure": @"info", @"arguments": @[@{@"alias": @""}, @{@"basic": @YES}]};
    XCTAssertEqualObjects([info plistValue], result, @"Basic info");

    info = [EXORpcInfoRequest infoByRID:rid types:EXORpcInfoRequestTypeCounts complete:nil];
    result = @{@"procedure": @"info", @"arguments": @[@{@"alias": @""}, @{@"counts": @YES}]};
    XCTAssertEqualObjects([info plistValue], result, @"Counts info");

    info = [EXORpcInfoRequest infoByRID:rid types:EXORpcInfoRequestTypeDescription complete:nil];
    result = @{@"procedure": @"info", @"arguments": @[@{@"alias": @""}, @{@"description": @YES}]};
    XCTAssertEqualObjects([info plistValue], result, @"Description info");

    info = [EXORpcInfoRequest infoByRID:rid types:EXORpcInfoRequestTypeKey complete:nil];
    result = @{@"procedure": @"info", @"arguments": @[@{@"alias": @""}, @{@"key": @YES}]};
    XCTAssertEqualObjects([info plistValue], result, @"Key info");

    info = [EXORpcInfoRequest infoByRID:rid types:EXORpcInfoRequestTypeShares complete:nil];
    result = @{@"procedure": @"info", @"arguments": @[@{@"alias": @""}, @{@"shares": @YES}]};
    XCTAssertEqualObjects([info plistValue], result, @"Shares info");

    info = [EXORpcInfoRequest infoByRID:rid types:EXORpcInfoRequestTypeUsage complete:nil];
    result = @{@"procedure": @"info", @"arguments": @[@{@"alias": @""}, @{@"usage": @YES}]};
    XCTAssertEqualObjects([info plistValue], result, @"Usage info");
}

@end
