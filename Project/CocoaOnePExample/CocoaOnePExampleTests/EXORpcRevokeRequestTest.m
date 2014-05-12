//
//  EXORpcRevokeRequestTest.m
//  CocoaOnePExample
//
//  Created by Michael Conrad Tadpol Tilstra on 5/12/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <EXORpc.h>

@interface EXORpcRevokeRequestTest : XCTestCase

@end

@implementation EXORpcRevokeRequestTest

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
    EXORpcRevokeRequest *revoke;
    NSDictionary *result;

    revoke = [EXORpcRevokeRequest revokeWithCode:@"a code" asShare:NO complete:nil];
    result = @{ @"procedure": @"revoke", @"arguments": @[@"client", @"a code"]};
    XCTAssertEqualObjects([revoke plistValue], result, @"Init a client code");

    revoke = [EXORpcRevokeRequest revokeWithCode:@"a code" asShare:YES complete:nil];
    result = @{ @"procedure": @"revoke", @"arguments": @[@"share", @"a code"]};
    XCTAssertEqualObjects([revoke plistValue], result, @"Init a client code");

}

@end
