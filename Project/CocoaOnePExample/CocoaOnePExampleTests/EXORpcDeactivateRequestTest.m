//
//  EXORpcDeactivateRequestTest.m
//  CocoaOnePExample
//
//  Created by Michael Conrad Tadpol Tilstra on 5/29/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EXORpc.h"

@interface EXORpcDeactivateRequestTest : XCTestCase

@end

@implementation EXORpcDeactivateRequestTest

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
    EXORpcDeactivateRequest *req;
    NSDictionary *result;

    req = [EXORpcDeactivateRequest deactivateShareWithCode:@"fake share code" complete:nil];
    result = @{@"procedure": @"deactivate", @"arguments": @[@"share", @"fake share code"]};
    XCTAssertEqualObjects([req plistValue], result, @"create a share activate request");

    req = [EXORpcDeactivateRequest deactivateClientWithCode:@"fake CIK." complete:nil];
    result = @{@"procedure": @"deactivate", @"arguments": @[@"client", @"fake CIK."]};
    XCTAssertEqualObjects([req plistValue], result, @"create a client activate request");
}


- (void)testComplete
{
    EXORpcDeactivateRequest *req;
    req = [EXORpcDeactivateRequest deactivateShareWithCode:@"fake share code" complete:^(NSError *error) {
        XCTAssertNil(error, @"Sucess has no error");
    }];
    [req doResult:@{@"id":@(0), @"status":@"ok"}];
}

@end
