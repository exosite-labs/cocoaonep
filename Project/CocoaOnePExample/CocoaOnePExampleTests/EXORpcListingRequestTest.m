//
//  EXORpcListingRequestTest.m
//  CocoaOnePExample
//
//  Created by Michael Conrad Tadpol Tilstra on 6/9/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <EXORpc.h>

@interface EXORpcListingRequestTest : XCTestCase

@end

@implementation EXORpcListingRequestTest

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
    EXORpcListingRequest *list;
    NSDictionary *results;

    list = [EXORpcListingRequest listingByType:EXORpcListTypeAll filter:EXORpcFilterTypeDefault complete:^(id a, id b){}];
    results = @{@"procedure": @"listing", @"arguments": @[@[@"client",@"dataport",@"datarule",@"dispatch"], @{}]};
    XCTAssertEqualObjects([list plistValue], results, @"Default list");

    list = [EXORpcListingRequest listingByType:EXORpcListTypeClient filter:EXORpcFilterTypeDefault complete:^(id a, id b){}];
    results = @{@"procedure": @"listing", @"arguments": @[@[@"client"], @{}]};
    XCTAssertEqualObjects([list plistValue], results, @"Client list");

    list = [EXORpcListingRequest listingByType:EXORpcListTypeDataport filter:EXORpcFilterTypeDefault complete:^(id a, id b){}];
    results = @{@"procedure": @"listing", @"arguments": @[@[@"dataport"], @{}]};
    XCTAssertEqualObjects([list plistValue], results, @"Dataport list");

    list = [EXORpcListingRequest listingByType:EXORpcListTypeDatarule filter:EXORpcFilterTypeDefault complete:^(id a, id b){}];
    results = @{@"procedure": @"listing", @"arguments": @[@[@"datarule"], @{}]};
    XCTAssertEqualObjects([list plistValue], results, @"Datarule list");

    list = [EXORpcListingRequest listingByType:EXORpcListTypeDispatch filter:EXORpcFilterTypeDefault complete:^(id a, id b){}];
    results = @{@"procedure": @"listing", @"arguments": @[@[@"dispatch"], @{}]};
    XCTAssertEqualObjects([list plistValue], results, @"Dispatch list");

    list = [EXORpcListingRequest listingByType:(EXORpcListTypeDispatch|EXORpcListTypeDataport) filter:EXORpcFilterTypeDefault complete:^(id a, id b){}];
    results = @{@"procedure": @"listing", @"arguments": @[@[@"dataport",@"dispatch"], @{}]};
    XCTAssertEqualObjects([list plistValue], results, @"Dataport & Dispatch list");

    list = [EXORpcListingRequest listingByType:EXORpcListTypeClient filter:EXORpcFilterTypeActivated complete:^(id a, id b){}];
    results = @{@"procedure": @"listing", @"arguments": @[@[@"client"], @{@"activated": @YES}]};
    XCTAssertEqualObjects([list plistValue], results, @"Activated filter");

    list = [EXORpcListingRequest listingByType:EXORpcListTypeClient filter:EXORpcFilterTypeAliased complete:^(id a, id b){}];
    results = @{@"procedure": @"listing", @"arguments": @[@[@"client"], @{@"aliased": @YES}]};
    XCTAssertEqualObjects([list plistValue], results, @"Activated filter");

    list = [EXORpcListingRequest listingByType:EXORpcListTypeClient filter:EXORpcFilterTypeOwned complete:^(id a, id b){}];
    results = @{@"procedure": @"listing", @"arguments": @[@[@"client"], @{@"owned": @YES}]};
    XCTAssertEqualObjects([list plistValue], results, @"Activated filter");

    list = [EXORpcListingRequest listingByType:EXORpcListTypeClient filter:EXORpcFilterTypePublic complete:^(id a, id b){}];
    results = @{@"procedure": @"listing", @"arguments": @[@[@"client"], @{@"public": @YES}]};
    XCTAssertEqualObjects([list plistValue], results, @"Activated filter");


}

@end
