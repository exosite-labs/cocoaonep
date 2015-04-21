//
//  EXORpcCreateRequestTest.m
//  CocoaOnePExample
//
//  Created by Michael Conrad Tadpol Tilstra on 12/9/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <EXORpc.h>

@interface EXORpcCreateRequestTest : XCTestCase

@end

@implementation EXORpcCreateRequestTest

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
    EXORpcCreateRequest *req;
    NSDictionary *result;
    
    EXORpcDataportResource *dp = [EXORpcDataportResource dataportWithName:@"dogeton" format:EXORpcDataportFormatFloat];

    req = [EXORpcCreateRequest createWithResource:dp complete:nil];
    result = @{@"procedure": @"create", @"arguments":@[ @"dataport", @{@"format": @"float", @"name": @"dogeton", @"visibility": @"parent" } ] };
    XCTAssertEqualObjects([req plistValue], result, @"Create a dataport");
    
}

- (void)testComplete
{
    EXORpcCreateRequest *req;
    EXORpcDataportResource *dp = [EXORpcDataportResource dataportWithName:@"dogeton" format:EXORpcDataportFormatFloat];
    req = [EXORpcCreateRequest createWithResource:dp complete:^(EXORpcResourceID *RID, NSError *error) {
        XCTAssertNil(error);
        XCTAssertEqualObjects(RID.rid, @"f3a7f2d7a9f7f470bbca01234567890123456789");
    }];
    [req doResult:@{@"id":@(0), @"status":@"ok", @"result":@"f3a7f2d7a9f7f470bbca01234567890123456789"}];

    // TODO: test when error is not nil
}

@end
