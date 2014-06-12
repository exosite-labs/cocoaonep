//
//  EXORpcUpdateRequestTest.m
//  CocoaOnePExample
//
//  Created by Michael Conrad Tadpol Tilstra on 6/12/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <EXORpc.h>

@interface EXORpcUpdateRequestTest : XCTestCase

@end

@implementation EXORpcUpdateRequestTest

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
    EXORpcUpdateRequest *update;
    NSDictionary *result;
    EXORpcResourceID *rid = [EXORpcResourceID resourceIDAsSelf];
    EXORpcClientResource *resource = [EXORpcClientResource resourceWithName:@"fob" meta:nil];

    update = [EXORpcUpdateRequest updateWithRID:rid resource:resource complete:nil];
    result = @{@"procedure":@"update", @"arguments":@[
                       @{@"alias":@""}, @{@"limits": @{
                                                  @"client": @"inherit",
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
                                                  },
                                          @"locked": @NO,
                                          @"name": @"fob",
                                          @"public": @NO,
                                          }
                       ]};
    XCTAssertEqualObjects([update plistValue], result, @"update ");
}

@end
