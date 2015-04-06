//
//  EXORpcRecordRequestTest.m
//  CocoaOnePExample
//
//  Created by Michael Conrad Tadpol Tilstra on 5/8/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <EXORpc.h>

@interface EXORpcRecordRequestTest : XCTestCase

@end

@implementation EXORpcRecordRequestTest

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
    EXORpcResourceID *rid = [EXORpcResourceID resourceIDAsSelf];
    NSArray *values = @[[EXORpcValue valueWithDate:[NSDate dateWithTimeIntervalSince1970:5656] number:@(42)],
                         [EXORpcValue valueWithDate:[NSDate dateWithTimeIntervalSince1970:9292] number:@(108)],
                        [EXORpcValue valueWithDate:[NSDate dateWithTimeIntervalSince1970:1509] number:@(90)]];
    EXORpcRecordRequest *record = [EXORpcRecordRequest recordWithRID:rid values:values complete:nil];

    NSDictionary *result = @{@"arguments": @[@{@"alias": @""}, @[@[@(5656), @(42)], @[@(9292), @(108)], @[@(1509), @(90)]], @{}],
                             @"procedure": @"record"};

    XCTAssertEqualObjects([record plistValue], result, @"create a record request");
}

- (void)testComplete
{
    EXORpcRecordRequest *req;
    req = [EXORpcRecordRequest recordWithRID:nil values:nil complete:^(NSError *error) {
        XCTAssertNil(error, @"Sucess has no error");
    }];
    [req doResult:@{@"id":@(0), @"status":@"ok"}];

    req = [EXORpcRecordRequest recordWithRID:nil values:nil complete:^(NSError *error) {
        XCTAssertNotNil(error);
        XCTAssertEqualObjects(error.domain, kEXORpcErrorDomain);
        XCTAssertEqual(error.code, kEXORpcErrorTypeRestricted);
    }];
    [req doResult:@{@"id":@(0), @"status":@"restricted"}];
}


@end
