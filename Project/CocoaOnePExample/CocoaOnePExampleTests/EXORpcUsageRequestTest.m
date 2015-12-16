//
//  EXORpcUsageRequestTest.m
//  CocoaOnePExample
//
//  Created by Michael Conrad Tadpol Tilstra on 6/12/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EXORpc.h"

@interface EXORpcUsageRequestTest : XCTestCase

@end

@implementation EXORpcUsageRequestTest

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
    EXORpcUsageRequest *usage;
    NSDictionary *result;
    EXORpcResourceID *rid = [EXORpcResourceID resourceIDAsSelf];
    NSDate *start = [NSDate dateWithTimeIntervalSince1970:1442];
    NSDate *end = [NSDate dateWithTimeIntervalSince1970:1942];

    usage = [EXORpcUsageRequest usageWithRID:rid metric:EXORpcUsageMetricsClient start:start end:end complete:nil];
    result = @{@"procedure":@"usage", @"arguments":@[@{@"alias":@""}, @"client", @(1442), @(1942)]};
    XCTAssertEqualObjects([usage plistValue], result, @"client usage");

    usage = [EXORpcUsageRequest usageWithRID:rid metric:EXORpcUsageMetricsDataport start:start end:end complete:nil];
    result = @{@"procedure":@"usage", @"arguments":@[@{@"alias":@""}, @"dataport", @(1442), @(1942)]};
    XCTAssertEqualObjects([usage plistValue], result, @"dataport usage");

    usage = [EXORpcUsageRequest usageWithRID:rid metric:EXORpcUsageMetricsDatarule start:start end:end complete:nil];
    result = @{@"procedure":@"usage", @"arguments":@[@{@"alias":@""}, @"datarule", @(1442), @(1942)]};
    XCTAssertEqualObjects([usage plistValue], result, @"datarule usage");

    usage = [EXORpcUsageRequest usageWithRID:rid metric:EXORpcUsageMetricsDispatch start:start end:end complete:nil];
    result = @{@"procedure":@"usage", @"arguments":@[@{@"alias":@""}, @"dispatch", @(1442), @(1942)]};
    XCTAssertEqualObjects([usage plistValue], result, @"dispatch usage");

    usage = [EXORpcUsageRequest usageWithRID:rid metric:EXORpcUsageMetricsEmail start:start end:end complete:nil];
    result = @{@"procedure":@"usage", @"arguments":@[@{@"alias":@""}, @"email", @(1442), @(1942)]};
    XCTAssertEqualObjects([usage plistValue], result, @"email usage");

    usage = [EXORpcUsageRequest usageWithRID:rid metric:EXORpcUsageMetricsHttp start:start end:end complete:nil];
    result = @{@"procedure":@"usage", @"arguments":@[@{@"alias":@""}, @"http", @(1442), @(1942)]};
    XCTAssertEqualObjects([usage plistValue], result, @"http usage");

    usage = [EXORpcUsageRequest usageWithRID:rid metric:EXORpcUsageMetricsShare start:start end:end complete:nil];
    result = @{@"procedure":@"usage", @"arguments":@[@{@"alias":@""}, @"share", @(1442), @(1942)]};
    XCTAssertEqualObjects([usage plistValue], result, @"share usage");

    usage = [EXORpcUsageRequest usageWithRID:rid metric:EXORpcUsageMetricsSms start:start end:end complete:nil];
    result = @{@"procedure":@"usage", @"arguments":@[@{@"alias":@""}, @"sms", @(1442), @(1942)]};
    XCTAssertEqualObjects([usage plistValue], result, @"SMS usage");

    usage = [EXORpcUsageRequest usageWithRID:rid metric:EXORpcUsageMetricsXmpp start:start end:end complete:nil];
    result = @{@"procedure":@"usage", @"arguments":@[@{@"alias":@""}, @"xmpp", @(1442), @(1942)]};
    XCTAssertEqualObjects([usage plistValue], result, @"XMPP usage");

}

@end
