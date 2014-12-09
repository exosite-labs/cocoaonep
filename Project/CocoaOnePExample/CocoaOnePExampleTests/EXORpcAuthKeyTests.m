//
//  EXORpcAuthKeyTests.m
//  CocoaOnePExample
//
//  Created by Michael Conrad Tadpol Tilstra on 3/15/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EXORpc.h"

@interface EXORpcAuthKeyTests : XCTestCase

@end

@implementation EXORpcAuthKeyTests

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

- (void)testAuthKey
{
    EXORpcAuthKey *auth;
    NSDictionary *dict;
    
    auth = [EXORpcAuthKey authWithCIK:@"e5f61a91cd50e7e5922b01234567890123456789"];
    XCTAssertEqualObjects(@{@"cik": @"e5f61a91cd50e7e5922b01234567890123456789"}, [auth plistValue], @"AuthKey with a CIK");
    
    auth = [EXORpcAuthKey authWithCIK:@"110527cc4dcf099af5be01234567890123456789" client:@"e5f61a91cd50e7e5922b01234567890123456789"];
    dict = @{@"cik": @"110527cc4dcf099af5be01234567890123456789", @"client_id": @"e5f61a91cd50e7e5922b01234567890123456789"};
    XCTAssertEqualObjects(dict, [auth plistValue], @"AuthKey with cik and client id");
    
    auth = [EXORpcAuthKey authWithCIK:@"3eb82b131c571c501af501234567890123456789" resource:@"88e9bc95a2eef8b6f0a001234567890123456789"];
    dict = @{@"cik": @"3eb82b131c571c501af501234567890123456789", @"resource_id": @"88e9bc95a2eef8b6f0a001234567890123456789"};
    XCTAssertEqualObjects(dict, [auth plistValue], @"AuthKey with cik and resource id");

    auth = [EXORpcAuthKey authWithCIK:@"ABCDEFGH"];
    XCTAssertNil(auth, @"nil if CIK isn't a CIK");

    auth = [EXORpcAuthKey authWithCIK:nil];
    XCTAssertNil(auth, @"nil param is nil result");

    auth = [EXORpcAuthKey authWithCIK:nil client:@"e5f61a91cd50e7e5922b01234567890123456789"];
    XCTAssertNil(auth, @"nil param is nil result");

    auth = [EXORpcAuthKey authWithCIK:@"3eb82b131c571c501af501234567890123456789" client:nil];
    XCTAssertNil(auth, @"nil param is nil result");

    auth = [EXORpcAuthKey authWithCIK:@"3eb82b131c571c501af501234567890123456789" client:@"012345"];
    XCTAssertNil(auth, @"nil if not valide RID");

    auth = [EXORpcAuthKey authWithCIK:nil resource:@"e5f61a91cd50e7e5922b01234567890123456789"];
    XCTAssertNil(auth, @"nil param is nil result");

    auth = [EXORpcAuthKey authWithCIK:@"3eb82b131c571c501af501234567890123456789" resource:nil];
    XCTAssertNil(auth, @"nil param is nil result");
    
    auth = [EXORpcAuthKey authWithCIK:@"3eb82b131c571c501af501234567890123456789" resource:@"098765654r"];
    XCTAssertNil(auth, @"nil if not valide RID");
}

- (void)testComparing
{
    EXORpcAuthKey *authA, *authB;
    
    authA = [EXORpcAuthKey authWithCIK:@"e5f61a91cd50e7e5922b01234567890123456789"];
    authB = [EXORpcAuthKey authWithCIK:@"e5f61a91cd50e7e5922b01234567890123456789"];
    XCTAssertEqualObjects(authA, authB, @"Testing isEqual");
    
    authA = [EXORpcAuthKey authWithCIK:@"110527cc4dcf099af5be01234567890123456789" client:@"e5f61a91cd50e7e5922b01234567890123456789"];
    authB = [EXORpcAuthKey authWithCIK:@"110527cc4dcf099af5be01234567890123456789" client:@"e5f61a91cd50e7e5922b01234567890123456789"];
    XCTAssertEqualObjects(authA, authB, @"Testing isEqual");

    authA = [EXORpcAuthKey authWithCIK:@"3eb82b131c571c501af501234567890123456789" resource:@"88e9bc95a2eef8b6f0a001234567890123456789"];
    authB = [EXORpcAuthKey authWithCIK:@"3eb82b131c571c501af501234567890123456789" resource:@"88e9bc95a2eef8b6f0a001234567890123456789"];
    XCTAssertEqualObjects(authA, authB, @"Testing isEqual");
}

@end
