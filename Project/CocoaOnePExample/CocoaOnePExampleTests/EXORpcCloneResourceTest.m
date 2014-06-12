//
//  EXORpcCloneResourceTest.m
//  CocoaOnePExample
//
//  Created by Michael Conrad Tadpol Tilstra on 6/12/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <EXORpc.h>

@interface EXORpcCloneResourceTest : XCTestCase

@end

@implementation EXORpcCloneResourceTest

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
    EXORpcCloneResource *clone;
    NSDictionary *result;
    EXORpcResourceID *rid;

    clone = [EXORpcCloneResource cloneWithCode:@"a share code" noaliases:YES nohistorical:NO];
    result = @{@"code": @"a share code", @"noaliases": @YES, @"nohistorical": @NO};
    XCTAssertEqualObjects([clone plistValue], result, @"clone a share");

    rid = [EXORpcResourceID resourceIDByRID:@"a resource id"];
    clone = [EXORpcCloneResource cloneWithRid:rid noaliases:NO nohistorical:YES];
    result = @{@"rid": @"a resource id", @"noaliases": @NO, @"nohistorical": @YES};
    XCTAssertEqualObjects([clone plistValue], result, @"clone a share");

    rid = [EXORpcResourceID resourceIDAsSelf];
    clone = [EXORpcCloneResource cloneWithRid:rid noaliases:NO nohistorical:YES];
    XCTAssertNil(clone, @"Cannot clone as self");

}

@end
