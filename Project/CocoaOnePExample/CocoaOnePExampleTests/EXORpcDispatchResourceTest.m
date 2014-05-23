//
//  EXORpcDispatchResourceTest.m
//  CocoaOnePExample
//
//  Created by Michael Conrad Tadpol Tilstra on 5/23/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <EXORpc.h>

@interface EXORpcDispatchResourceTest : XCTestCase

@end

@implementation EXORpcDispatchResourceTest

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
    EXORpcDispatchResource *dispatch;
    EXORpcResourceID *rid = [EXORpcResourceID resourceIDAsSelf];
    NSDictionary *result;


    dispatch = [EXORpcDispatchResource dispatchSMSTo:@"19995551234" message:@"this is a test" on:rid];
    result = @{@"method": @"sms",
               @"message": @"this is a test",
               @"locked": @NO,
               @"public": @NO,
               @"recipient": @"19995551234",
               @"subscribe": @{@"alias": @""},
               };
    XCTAssertEqualObjects([dispatch plistValue], result, @"Simple SMS dispatch");

    dispatch = [EXORpcDispatchResource dispatchEmailTo:@"bob@build.er" subject:@"An Email!" message:@"Just for you!" on:rid];
    result = @{@"method": @"email",
               @"message": @"Just for you!",
               @"locked": @NO,
               @"public": @NO,
               @"subject": @"An Email!",
               @"recipient": @"bob@build.er",
               @"subscribe": @{@"alias": @""},
               };
    XCTAssertEqualObjects([dispatch plistValue], result, @"Simple Email dispatch");

    dispatch = [EXORpcDispatchResource dispatchWithName:@"My Dispatch" method:EXORpcDispactMethodXmpp to:@"where@xmpp.org" subject:nil message:@"a tester" on:rid];
    result = @{@"method": @"xmpp",
               @"name": @"My Dispatch",
               @"message": @"a tester",
               @"locked": @NO,
               @"public": @NO,
               @"recipient": @"where@xmpp.org",
               @"subscribe": @{@"alias": @""},
               };
    XCTAssertEqualObjects([dispatch plistValue], result, @"Somewhat more generic dispatch");

}

@end
