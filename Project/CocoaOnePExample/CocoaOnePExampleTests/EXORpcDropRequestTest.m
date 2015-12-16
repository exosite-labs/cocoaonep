//
//  EXORpcDropRequestTest.m
//  CocoaOnePExample
//
//  Created by Michael Conrad Tadpol Tilstra on 5/29/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EXORpc.h"

@interface EXORpcDropRequestTest : XCTestCase

@end

@implementation EXORpcDropRequestTest

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
    EXORpcDropRequest *drop;
    NSDictionary *result;

    EXORpcResourceID *rid = [EXORpcResourceID resourceIDAsSelf];
    drop = [EXORpcDropRequest dropWithRID:rid complete:nil];
    result = @{ @"procedure": @"drop", @"arguments": @[@{@"alias": @""}]};
    XCTAssertEqualObjects([drop plistValue], result, @"A Drop Request");
}


- (void)testComplete
{
    EXORpcDropRequest *req;
    req = [EXORpcDropRequest dropWithRID:nil complete:^(NSError *error) {
        XCTAssertNil(error, @"Sucess has no error");
    }];
    [req doResult:@{@"id":@(0), @"status":@"ok"}];

    req = [EXORpcDropRequest dropWithRID:nil complete:^(NSError *error) {
        XCTAssertNotNil(error);
        XCTAssertEqualObjects(error.domain, kEXORpcErrorDomain);
        XCTAssertEqual(error.code, kEXORpcErrorTypeRestricted);
    }];
    [req doResult:@{@"id":@(0), @"status":@"restricted"}];
}

@end
