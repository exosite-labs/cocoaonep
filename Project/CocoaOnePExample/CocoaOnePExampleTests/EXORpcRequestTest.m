//
//  EXORpcRequestTest.m
//  CocoaOnePExample
//
//  Created by Michael Conrad Tadpol Tilstra on 6/9/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EXORpc.h"

@interface EXORpcRequestTest : XCTestCase

@end

@implementation EXORpcRequestTest

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
    EXORpcRequest *req;

    req = [[EXORpcRequest alloc] init];
    XCTAssertEqualObjects([req plistValue], @{}, @"Base class always returns empty for plist");
    XCTAssertEqualObjects(req.rid, [EXORpcResourceID resourceIDAsSelf], @"rid is self by default");

}

- (void)testCodeFromStatus
{
    EXORpcRequest *req = [EXORpcRequest new];
    XCTAssertEqual([req codeFromStatus:@"ok"], kEXORpcErrorTypeOk, @"Ok error code");
    XCTAssertEqual([req codeFromStatus:@"noauth"], kEXORpcErrorTypeNoAuth, @"No Auth error code");
    XCTAssertEqual([req codeFromStatus:@"invalid"], kEXORpcErrorTypeInvalid, @"Invalid error code");
    XCTAssertEqual([req codeFromStatus:@"restricted"], kEXORpcErrorTypeRestricted, @"Restricted error code");
    XCTAssertEqual([req codeFromStatus:@"asdfgh"], kEXORpcErrorTypeUnknown, @"Unknown error code");
    XCTAssertEqual([req codeFromStatus:nil], kEXORpcErrorTypeUnknown, @"Unknown error code");
}

- (void)testErrorFromStatus
{
    EXORpcRequest *req = [EXORpcRequest new];
    NSError *error;

    error = [req errorFromStatus:@{@"status": @"ok"}];
    XCTAssertNil(error, @"Ok status is nil error");

    error = [req errorFromStatus:@{@"status": @"invalid"}];
    XCTAssertEqualObjects([NSError errorWithDomain:kEXORpcErrorDomain code:kEXORpcErrorTypeInvalid userInfo:@{NSLocalizedDescriptionKey: @"invalid"}], error, @"invalid error status");

    error = [req errorFromStatus:nil];
    XCTAssertEqualObjects([NSError errorWithDomain:kEXORpcErrorDomain code:kEXORpcErrorTypeUnknown userInfo:nil], error, @"nil status");
}

@end
