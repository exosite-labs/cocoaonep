//
//  EXOWebSocketSubscribeRequestTest.m
//  CocoaOnePExample
//
//  Created by Michael Conrad Tadpol Tilstra on 11/5/15.
//  Copyright © 2015 Exosite. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <EXOWebSocket.h>

@interface EXOWebSocketSubscribeRequestTest : XCTestCase

@end

@implementation EXOWebSocketSubscribeRequestTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAllocAndInit
{
    EXOWebSocketSubscribeRequest *sub;
    NSDictionary *result;

    EXORpcResourceID *rid = [EXORpcResourceID resourceIDAsSelf];
    sub = [EXOWebSocketSubscribeRequest subscribeWithRID:rid update:^(EXORpcValue *value, NSError *error) {}];
    result = @{ @"procedure": @"subscribe", @"arguments": @[@{@"alias": @""}, @{}]};
    XCTAssertEqualObjects([sub plistValue], result, @"A Subscribe Request");
}


- (void)testComplete
{
    EXOWebSocketSubscribeRequest *sub;
    EXORpcResourceID *rid = [EXORpcResourceID resourceIDAsSelf];
    sub = [EXOWebSocketSubscribeRequest subscribeWithRID:rid update:^(EXORpcValue *value, NSError *error) {
        XCTAssertNil(error, @"Sucess has no error");
        XCTAssertEqual(value.when.timeIntervalSince1970, 1234567586, @"Timestamp matched");
        XCTAssertEqual(value.numberValue.integerValue, 42, @"Value matched");
    }];
    [sub doResult:@{@"id":@(0), @"status":@"ok", @"result":@[@(1234567586),@(42)]}];

    sub = [EXOWebSocketSubscribeRequest subscribeWithRID:rid update:^(EXORpcValue *value, NSError *error) {
        XCTAssertNotNil(error);
        XCTAssertEqualObjects(error.domain, kEXORpcErrorDomain);
        XCTAssertEqual(error.code, kEXORpcErrorTypeRestricted);
    }];
    [sub doResult:@{@"id":@(0), @"status":@"restricted"}];
}


@end
