//
//  EXORpcActivateRequestTest.m
//  CocoaOnePExample
//
//  Created by Michael Conrad Tadpol Tilstra on 5/23/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <EXORpc.h>

@interface EXORpcActivateRequestTest : XCTestCase

@end

@implementation EXORpcActivateRequestTest

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
    EXORpcActivateRequest *req;
    NSDictionary *result;

    req = [EXORpcActivateRequest activateShareWithCode:@"fake share code" complete:nil];
    result = @{@"procedure": @"activate", @"arguments": @[@"share", @"fake share code"]};
    XCTAssertEqualObjects([req plistValue], result, @"create a share activate request");

    req = [EXORpcActivateRequest activateClientWithCode:@"fake CIK." complete:nil];
    result = @{@"procedure": @"activate", @"arguments": @[@"client", @"fake CIK."]};
    XCTAssertEqualObjects([req plistValue], result, @"create a client activate request");
}

@end
