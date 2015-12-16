//
//  EXORpcWaitRequestTest.m
//  CocoaOnePExample
//
//  Created by Michael Conrad Tadpol Tilstra on 10/24/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "EXORpc.h"

@interface EXORpcWaitRequestTest : XCTestCase

@end

@implementation EXORpcWaitRequestTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAllocAndInit
{
    EXORpcWaitRequest *wait;
    NSDictionary *result;
    EXORpcResourceID *rid = [EXORpcResourceID resourceIDAsSelf];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:42];

    wait = [EXORpcWaitRequest waitRequestWithRIDs:@[rid] timeoutAfter:nil since:nil complete:^(id a, id b){}];
    result = @{@"procedure": @"wait", @"arguments": @[@{@"alias": @""}, @{}]};
    XCTAssertEqualObjects([wait plistValue], result, @"simple wait");
    
    wait = [EXORpcWaitRequest waitRequestWithRIDs:@[rid] timeoutAfter:@(200) since:nil complete:^(id a, id b){}];
    result = @{@"procedure": @"wait", @"arguments": @[@{@"alias": @""}, @{@"timeout":@(200000)}]};
    XCTAssertEqualObjects([wait plistValue], result, @"wait with timeout");

    wait = [EXORpcWaitRequest waitRequestWithRIDs:@[rid] timeoutAfter:@(200) since:date complete:^(id a, id b){}];
    result = @{@"procedure": @"wait", @"arguments": @[@{@"alias": @""}, @{@"timeout":@(200000), @"since":@(42)}]};
    XCTAssertEqualObjects([wait plistValue], result, @"wait with timeout and since");

    wait = [EXORpcWaitRequest waitRequestWithRIDs:@[rid] complete:^(id a, id b){}];
    result = @{@"procedure": @"wait", @"arguments": @[@{@"alias": @""}, @{}]};
    XCTAssertEqualObjects([wait plistValue], result, @"wait simple init");

    wait = [EXORpcWaitRequest waitRequestWithRIDs:@[rid] timeoutAfter:@(88) complete:^(id a, id b){}];
    result = @{@"procedure": @"wait", @"arguments": @[@{@"alias": @""}, @{@"timeout":@(88000)}]};
    XCTAssertEqualObjects([wait plistValue], result, @"wait timeout init");

}

@end
