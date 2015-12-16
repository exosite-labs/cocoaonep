//
//  EXORpcWriteRequestTest.m
//  CocoaOnePExample
//
//  Created by Michael Conrad Tadpol Tilstra on 6/12/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EXORpc.h"

@interface EXORpcWriteRequestTest : XCTestCase

@end

@implementation EXORpcWriteRequestTest

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
    EXORpcWriteRequest *write;
    NSDictionary *result;
    EXORpcResourceID *rid = [EXORpcResourceID resourceIDAsSelf];
    EXORpcValue *value;

    write = [EXORpcWriteRequest writeWithRID:rid number:@(42) complete:^(id e){}];
    result = @{@"procedure":@"write", @"arguments":@[@{@"alias":@""}, @(42)]};
    XCTAssertEqualObjects([write plistValue], result, @"write a number");

    write = [EXORpcWriteRequest writeWithRID:rid string:@"A string to write" complete:^(id e){}];
    result = @{@"procedure":@"write", @"arguments":@[@{@"alias":@""}, @"A string to write"]};
    XCTAssertEqualObjects([write plistValue], result, @"write a string");

    value = [EXORpcValue valueWithDate:[NSDate dateWithTimeIntervalSince1970:42] number:@(123456)];
    write = [EXORpcWriteRequest writeWithRID:rid value:value complete:^(id e){}];
    result = @{@"procedure":@"write", @"arguments":@[@{@"alias":@""}, @(123456)]};
    XCTAssertEqualObjects([write plistValue], result, @"write a number Value");

    value = [EXORpcValue valueWithDate:[NSDate dateWithTimeIntervalSince1970:42] string:@"bob's place"];
    write = [EXORpcWriteRequest writeWithRID:rid value:value complete:^(id e){}];
    result = @{@"procedure":@"write", @"arguments":@[@{@"alias":@""}, @"bob's place"]};
    XCTAssertEqualObjects([write plistValue], result, @"write a string Value");

    id plist = @[@{@"a": @"tree"},@"of", @{@"things": @(0)}, @NO];
    write = [EXORpcWriteRequest writeWithRID:rid plist:plist complete:^(id e){}];
    result = @{@"procedure":@"write", @"arguments":@[@{@"alias":@""}, @"[{\"a\":\"tree\"},\"of\",{\"things\":0},false]"]};
    XCTAssertEqualObjects([write plistValue], result, @"write a JSON clean PList");

}

- (void)testComplete
{
    EXORpcResourceID *rid = [EXORpcResourceID resourceIDAsSelf];
    EXORpcWriteRequest *req;
    req = [EXORpcWriteRequest writeWithRID:rid number:@(42) complete:^(NSError *error) {
        XCTAssertNil(error, @"Sucess has no error");
    }];
    [req doResult:@{@"id":@(0), @"status":@"ok"}];

    req = [EXORpcWriteRequest writeWithRID:rid number:@(42) complete:^(NSError *error) {
        XCTAssertNotNil(error);
        XCTAssertEqualObjects(error.domain, kEXORpcErrorDomain);
        XCTAssertEqual(error.code, kEXORpcErrorTypeRestricted);
    }];
    [req doResult:@{@"id":@(0), @"status":@"restricted"}];
}



@end
