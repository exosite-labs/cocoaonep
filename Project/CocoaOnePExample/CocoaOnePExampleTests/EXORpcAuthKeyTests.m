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
    
    auth = [EXORpcAuthKey authWithCIK:@"ABCDEFG"];
    XCTAssertEqualObjects(@{@"cik": @"ABCDEFG"}, [auth plistValue], @"AuthKey with a CIK");
    
    auth = [EXORpcAuthKey authWithCIK:@"HIJKLMN" client:@"OPQRSTU"];
    dict = @{@"cik": @"HIJKLMN", @"client_id": @"OPQRSTU"};
    XCTAssertEqualObjects(dict, [auth plistValue], @"AuthKey with cik and client id");
    
    auth = [EXORpcAuthKey authWithCIK:@"VWYXZ0123" resource:@"456789"];
    dict = @{@"cik": @"VWYXZ0123", @"resource_id": @"456789"};
    XCTAssertEqualObjects(dict, [auth plistValue], @"AuthKey with cik and resource id");
    
}

@end
