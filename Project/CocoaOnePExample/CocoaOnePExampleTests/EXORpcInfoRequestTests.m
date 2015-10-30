//
//  EXORpcInfoRequestTests.m
//  CocoaOnePExample
//
//  Created by Michael Conrad Tadpol Tilstra on 4/8/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EXORpc.h"

@interface EXORpcInfoRequestTests : XCTestCase

@end

@implementation EXORpcInfoRequestTests

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

    info = [EXORpcInfoRequest infoByRID:[EXORpcResourceID resourceIDAsSelf] types:EXORpcInfoRequestTypeAll complete:^(id a, id b){}];
    result = @{@"procedure": @"info", @"arguments": @[@{@"alias": @""}, @{}]};
    XCTAssertEqualObjects(result, [info plistValue], @"Request for All fields");
    
    info = [EXORpcInfoRequest infoByRID:[EXORpcResourceID resourceIDAsSelf] types:EXORpcInfoRequestTypeAliases complete:^(id a, id b){}];
    result = @{@"procedure": @"info", @"arguments": @[@{@"alias": @""}, @{@"aliases": @YES}]};
    XCTAssertEqualObjects(result, [info plistValue], @"Request for Aliases field");

    info = [EXORpcInfoRequest infoByRID:[EXORpcResourceID resourceIDAsSelf] types:EXORpcInfoRequestTypeBasic complete:^(id a, id b){}];
    result = @{@"procedure": @"info", @"arguments": @[@{@"alias": @""}, @{@"basic": @YES}]};
    XCTAssertEqualObjects(result, [info plistValue], @"Request for Basic field");

    info = [EXORpcInfoRequest infoByRID:[EXORpcResourceID resourceIDAsSelf] types:EXORpcInfoRequestTypeComments complete:^(id a, id b){}];
    result = @{@"procedure": @"info", @"arguments": @[@{@"alias": @""}, @{@"comments": @YES}]};
    XCTAssertEqualObjects(result, [info plistValue], @"Request for Comments field");

    info = [EXORpcInfoRequest infoByRID:[EXORpcResourceID resourceIDAsSelf] types:EXORpcInfoRequestTypeCounts complete:^(id a, id b){}];
    result = @{@"procedure": @"info", @"arguments": @[@{@"alias": @""}, @{@"counts": @YES}]};
    XCTAssertEqualObjects(result, [info plistValue], @"Request for Counts field");

    info = [EXORpcInfoRequest infoByRID:[EXORpcResourceID resourceIDAsSelf] types:EXORpcInfoRequestTypeDescription complete:^(id a, id b){}];
    result = @{@"procedure": @"info", @"arguments": @[@{@"alias": @""}, @{@"description": @YES, @"basic": @YES}]};
    XCTAssertEqualObjects(result, [info plistValue], @"Request for Description field");

    info = [EXORpcInfoRequest infoByRID:[EXORpcResourceID resourceIDAsSelf] types:EXORpcInfoRequestTypeKey complete:^(id a, id b){}];
    result = @{@"procedure": @"info", @"arguments": @[@{@"alias": @""}, @{@"key": @YES}]};
    XCTAssertEqualObjects(result, [info plistValue], @"Request for Key field");

    info = [EXORpcInfoRequest infoByRID:[EXORpcResourceID resourceIDAsSelf] types:EXORpcInfoRequestTypeShares complete:^(id a, id b){}];
    result = @{@"procedure": @"info", @"arguments": @[@{@"alias": @""}, @{@"shares": @YES}]};
    XCTAssertEqualObjects(result, [info plistValue], @"Request for Shares field");

    info = [EXORpcInfoRequest infoByRID:[EXORpcResourceID resourceIDAsSelf] types:EXORpcInfoRequestTypeTagged complete:^(id a, id b){}];
    result = @{@"procedure": @"info", @"arguments": @[@{@"alias": @""}, @{@"tagged": @YES}]};
    XCTAssertEqualObjects(result, [info plistValue], @"Request for Tagged field");

    info = [EXORpcInfoRequest infoByRID:[EXORpcResourceID resourceIDAsSelf] types:EXORpcInfoRequestTypeTags complete:^(id a, id b){}];
    result = @{@"procedure": @"info", @"arguments": @[@{@"alias": @""}, @{@"tags": @YES}]};
    XCTAssertEqualObjects(result, [info plistValue], @"Request for Tags field");

    info = [EXORpcInfoRequest infoByRID:[EXORpcResourceID resourceIDAsSelf] types:EXORpcInfoRequestTypeUsage complete:^(id a, id b){}];
    result = @{@"procedure": @"info", @"arguments": @[@{@"alias": @""}, @{@"usage": @YES}]};
    XCTAssertEqualObjects(result, [info plistValue], @"Request for Usage field");

    info = [EXORpcInfoRequest infoByRID:[EXORpcResourceID resourceIDAsSelf] types:(EXORpcInfoRequestTypeUsage | EXORpcInfoRequestTypeAliases) complete:^(id a, id b){}];
    result = @{@"procedure": @"info", @"arguments": @[@{@"alias": @""}, @{@"aliases": @YES, @"usage": @YES}]};
    XCTAssertEqualObjects(result, [info plistValue], @"Request for Usage and Aliases field");


    info = [EXORpcInfoRequest infoByRID:[EXORpcResourceID resourceIDAsSelf] types:(EXORpcInfoRequestTypeAliases |
                                                                                   EXORpcInfoRequestTypeBasic |
                                                                                   EXORpcInfoRequestTypeComments |
                                                                                   EXORpcInfoRequestTypeCounts |
                                                                                   EXORpcInfoRequestTypeDescription |
                                                                                   EXORpcInfoRequestTypeKey | 
                                                                                   EXORpcInfoRequestTypeShares | 
                                                                                   EXORpcInfoRequestTypeTagged | 
                                                                                   EXORpcInfoRequestTypeTags | 
                                                                                   EXORpcInfoRequestTypeUsage) complete:^(id a, id b){}];
    result = @{@"procedure": @"info", @"arguments": @[@{@"alias": @""}, @{@"aliases": @YES,
                                                                          @"basic": @YES,
                                                                          @"comments": @YES,
                                                                          @"counts": @YES,
                                                                          @"description": @YES,
                                                                          @"key": @YES,
                                                                          @"shares": @YES,
                                                                          @"tagged": @YES,
                                                                          @"tags": @YES,
                                                                          @"usage": @YES
                                                                          }]};
    XCTAssertEqualObjects(result, [info plistValue], @"Request for All (listed out) field");

}

@end
