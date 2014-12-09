//
//  EXORpcLookupRequestTests.m
//  CocoaOnePExample
//
//  Created by Michael Conrad Tadpol Tilstra on 4/22/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EXORpc.h"

@interface EXORpcLookupRequestTests : XCTestCase

@end

@implementation EXORpcLookupRequestTests

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
    EXORpcLookupRequest *req;
    NSDictionary *result;

    req = [EXORpcLookupRequest lookupWithType:EXORpcLookupTypeAlias item:@"this is a test" complete:nil];
    result = @{@"procedure": @"lookup", @"arguments": @[@"alias", @"this is a test"]};
    XCTAssertEqualObjects(result, [req plistValue], @"Request for Alias type");

    req = [EXORpcLookupRequest lookupWithType:EXORpcLookupTypeOwner item:@"this is a test" complete:nil];
    result = @{@"procedure": @"lookup", @"arguments": @[@"owner", @"this is a test"]};
    XCTAssertEqualObjects(result, [req plistValue], @"Request for Owner type");

    req = [EXORpcLookupRequest lookupWithType:EXORpcLookupTypeShared item:@"this is a test" complete:nil];
    result = @{@"procedure": @"lookup", @"arguments": @[@"shared", @"this is a test"]};
    XCTAssertEqualObjects(result, [req plistValue], @"Request for Shared type");

}

- (void)testComplete
{
    EXORpcLookupRequest *req;
    req = [EXORpcLookupRequest lookupWithType:EXORpcLookupTypeAlias item:@"this is a test" complete:^(NSString *result, NSError *error) {
        XCTAssertNil(error);
        XCTAssertEqualObjects(result, @"f3a7f2d7a9f7f470bbca01234567890123456789");
    }];
    [req doResult:@{@"id":@(0), @"status":@"ok", @"result":@"f3a7f2d7a9f7f470bbca01234567890123456789"}];

    // TODO: test when error is not nil
}

@end
