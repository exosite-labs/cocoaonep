//
//  EXORpcShareRequestTest.m
//  CocoaOnePExample
//
//  Created by Michael Conrad Tadpol Tilstra on 6/12/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <EXORpc.h>

@interface EXORpcShareRequestTest : XCTestCase

@end

@implementation EXORpcShareRequestTest

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
    EXORpcShareRequest *share;
    NSDictionary *result;
    EXORpcResourceID *rid = [EXORpcResourceID resourceIDAsSelf];

    share = [EXORpcShareRequest shareWithRID:rid meta:@"some meta about meta"];
    result = @{@"procedure":@"share", @"arguments":@[@{@"alias":@""}, @{@"meta": @"some meta about meta"}]};
    XCTAssertEqualObjects([share plistValue], result, @"init with meta");

    share = [EXORpcShareRequest shareWithRID:rid];
    result = @{@"procedure":@"share", @"arguments":@[@{@"alias":@""}, @{}]};
    XCTAssertEqualObjects([share plistValue], result, @"init without meta");

}

@end
