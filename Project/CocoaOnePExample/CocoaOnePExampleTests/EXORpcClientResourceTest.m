//
//  EXORpcClientResourceTest.m
//  CocoaOnePExample
//
//  Created by Michael Conrad Tadpol Tilstra on 5/23/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <EXORpc.h>

@interface EXORpcClientResourceTest : XCTestCase

@end

@implementation EXORpcClientResourceTest

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
    EXORpcClientResource *resource;
    NSDictionary *result;
    NSDictionary *limits;

    resource = [EXORpcClientResource resourceWithName:@"A test Resource" meta:@"some meta here"];
    limits = @{@"client": @"inherit",
               @"dataport": @"inherit",
               @"datarule": @"inherit",
               @"disk": @"inherit",
               @"dispatch": @"inherit",
               @"email": @"inherit",
               @"email_bucket": @"inherit",
               @"http": @"inherit",
               @"http_bucket": @"inherit",
               @"io": @"inherit",
               @"share": @"inherit",
               @"sms": @"inherit",
               @"sms_bucket": @"inherit",
               @"xmpp": @"inherit",
               @"xmpp_bucket": @"inherit",
    };
    result = @{@"limits": limits, @"locked": @NO, @"name":@"A test Resource", @"meta": @"some meta here", @"public": @NO};
    XCTAssertEqualObjects([resource plistValue], result, @"short create");

    resource = [EXORpcClientResource resourceWithName:@"A test Resource" meta:@"some meta here" public:YES locked:YES limits:nil];
    result = @{@"limits": limits, @"locked": @YES, @"name":@"A test Resource", @"meta": @"some meta here", @"public": @YES};
    XCTAssertEqualObjects([resource plistValue], result, @"long create");


    resource = [EXORpcClientResource resourceWithName:@"A test Resource" meta:@"some meta here" public:NO locked:NO limits:@{@"sms":@(42)}];
    limits = @{@"client": @"inherit",
               @"dataport": @"inherit",
               @"datarule": @"inherit",
               @"disk": @"inherit",
               @"dispatch": @"inherit",
               @"email": @"inherit",
               @"email_bucket": @"inherit",
               @"http": @"inherit",
               @"http_bucket": @"inherit",
               @"io": @"inherit",
               @"share": @"inherit",
               @"sms": @(42),
               @"sms_bucket": @"inherit",
               @"xmpp": @"inherit",
               @"xmpp_bucket": @"inherit",
               };
    result = @{@"limits": limits, @"locked": @NO, @"name":@"A test Resource", @"meta": @"some meta here", @"public": @NO};
    XCTAssertEqualObjects([resource plistValue], result, @"create with limits");

}

@end
