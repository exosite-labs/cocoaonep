//
//  EXORpcDropRequestTest.m
//  CocoaOnePExample
//
//  Created by Michael Conrad Tadpol Tilstra on 5/29/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <EXORpc.h>

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

- (void)testInitAndAlloc
{
    EXORpcDropRequest *drop;
    NSDictionary *result;

    EXORpcResourceID *rid = [EXORpcResourceID resourceIDAsSelf];
    drop = [EXORpcDropRequest dropWithRID:rid complete:nil];
    result = @{ @"procedure": @"drop", @"arguments": @[@{@"alias": @""}]};
    XCTAssertEqualObjects([drop plistValue], result, @"A Drop Request");
}

@end
