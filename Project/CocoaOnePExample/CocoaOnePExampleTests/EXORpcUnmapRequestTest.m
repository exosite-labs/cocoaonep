//
//  EXORpcUnmapRequestTest.m
//  CocoaOnePExample
//
//  Created by Michael Conrad Tadpol Tilstra on 5/16/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EXORpc.h"

@interface EXORpcUnmapRequestTest : XCTestCase

@end

@implementation EXORpcUnmapRequestTest

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
    EXORpcUnmapRequest *unmap;
    NSDictionary *result;

    unmap = [EXORpcUnmapRequest unmapWithAlias:@"bob" complete:nil];
    result = @{ @"procedure": @"unmap", @"arguments": @[@"alias", @"bob"]};
    XCTAssertEqualObjects([unmap plistValue], result, @"Allocate & initialize unmap");
}

- (void)testComplete
{
    EXORpcUnmapRequest *req;
    req = [EXORpcUnmapRequest unmapWithAlias:@"bob" complete:^(NSError *error) {
        XCTAssertNil(error, @"Sucess has no error");
    }];
    [req doResult:@{@"id":@(0), @"status":@"ok"}];
}


@end
