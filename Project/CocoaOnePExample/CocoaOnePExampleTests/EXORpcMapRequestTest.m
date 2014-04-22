//
//  EXORpcMapRequestTest.m
//  CocoaOnePExample
//
//  Created by Michael Conrad Tadpol Tilstra on 4/22/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EXORpc.h"

@interface EXORpcMapRequestTest : XCTestCase

@end

@implementation EXORpcMapRequestTest

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
    EXORpcMapRequest *map;
    NSDictionary *result;

    map = [EXORpcMapRequest mapWithRID:[EXORpcResourceID resourceIDAsSelf] to:@"This is a Test" complete:nil];
    result = @{ @"procedure": @"map", @"arguments": @[@"alias", @{@"alias": @""}, @"This is a Test"]};
    XCTAssertEqualObjects(result, [map plistValue], @"Request for map");

}

@end
