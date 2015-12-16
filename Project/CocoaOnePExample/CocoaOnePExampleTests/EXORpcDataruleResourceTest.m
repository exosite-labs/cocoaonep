//
//  EXORpcDataruleResourceTest.m
//  CocoaOnePExample
//
//  Created by Michael Conrad Tadpol Tilstra on 6/19/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EXORpc.h"

@interface EXORpcDataruleResourceTest : XCTestCase

@end

@implementation EXORpcDataruleResourceTest

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
    EXORpcDataruleResource *datarule;
    NSDictionary *result;
    EXORpcResourceID *rid = [EXORpcResourceID resourceIDAsSelf];
    EXORpcDataruleTimeout *timeout = [EXORpcDataruleTimeout dataruleTimeoutWithTimeout:@(12) repeat:NO];

    datarule = [EXORpcDataruleResource dataruleWithName:@"test" rule:timeout subscribe:rid];
    result = @{
        @"format": @"integer",
        @"name": @"test",
        @"retention": @{@"count": @"infinity", @"duration": @"infinity"},
        @"rule": @{
            @"timeout": @{
                @"repeat": @NO,
                @"timeout": @(12),
            },
        },
        @"subscribe": @{@"alias": @""}
    };
    XCTAssertEqualObjects([datarule plistValue], result, @"Rule datarule");

    datarule = [EXORpcDataruleResource dataruleWithName:@"test" rule:timeout subscribe:[EXORpcResourceID invalid]];
    result = @{
               @"format": @"integer",
               @"name": @"test",
               @"retention": @{@"count": @"infinity", @"duration": @"infinity"},
               @"rule": @{
                       @"timeout": @{
                               @"repeat": @NO,
                               @"timeout": @(12),
                               },
                       },
               @"subscribe": [NSNull null]
               };
    XCTAssertEqualObjects([datarule plistValue], result, @"Rule datarule; clear subscription");
    
    datarule = [EXORpcDataruleResource dataruleWithName:@"script test" script:@"# A lua script."];
    result = @{
        @"format": @"string",
        @"name": @"script test",
        @"retention": @{@"count": @(1000), @"duration": @"infinity"},
        @"rule": @{
            @"script": @"# A lua script."
        }
    };
    XCTAssertEqualObjects([datarule plistValue], result, @"Rule datarule");

    result = @{
               @"format": @"integer",
               @"name": @"test",
               @"retention": @{@"count": @"infinity", @"duration": @"infinity"},
               @"rule": @{
                       @"timeout": @{
                               @"repeat": @NO,
                               @"timeout": @(12),
                               },
                       },
               @"subscribe": @"7de6dd91901d3f486829ef6feb9cb6c8094e26ed",
               @"preprocess": @[]
               };
    datarule = [[EXORpcDataruleResource alloc] initWithPList:result];
    XCTAssertEqualObjects([datarule plistValue], result, @"Init from plist");

    datarule = [[EXORpcDataruleResource alloc] initWithName:@"test" meta:@"meta" public:NO format:EXORpcDataportFormatUnchanged retention:nil rule:timeout subscribe:rid preprocess:nil];
    result = @{
               @"name": @"test",
               @"meta": @"meta",
               @"retention": @{@"count": @"infinity", @"duration": @"infinity"},
               @"rule": @{
                       @"timeout": @{
                               @"repeat": @NO,
                               @"timeout": @(12),
                               },
                       },
               @"subscribe": @{@"alias":@""},
               };
    XCTAssertEqualObjects([datarule plistValue], result, @"Unchanged format");

}

@end
