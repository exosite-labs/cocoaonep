//
//  EXORpcResourceTest.m
//  CocoaOnePExample
//
//  Created by Michael Conrad Tadpol Tilstra on 6/12/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EXORpc.h"

@interface EXORpcResourceTest : XCTestCase

@end

@implementation EXORpcResourceTest

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
    EXORpcResource *res;

    res = [EXORpcResource resourceWithName:@"bob" meta:@"{\"foo\":true}" public:YES];
    XCTAssertEqualObjects([res plistValue], @[], @"Init res");
    XCTAssertEqualObjects(res.name, @"bob", @"name check");
    XCTAssertEqualObjects(res.meta, @"{\"foo\":true}", @"meta check");
    XCTAssertEqual(res.public, YES, @"public check");

    res = [EXORpcResource resourceWithName:@"bar" meta:@"{\"quux\":9}"];
    XCTAssertEqualObjects([res plistValue], @[], @"Init res");
    XCTAssertEqualObjects(res.name, @"bar", @"name check");
    XCTAssertEqualObjects(res.meta, @"{\"quux\":9}", @"meta check");
    XCTAssertEqual(res.public, NO, @"public check");
}

@end
