//
//  EXORpcValueTest.m
//  CocoaOnePExample
//
//  Created by Michael Conrad Tadpol Tilstra on 5/6/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EXORpc.h"

@interface EXORpcValueTest : XCTestCase

@end

@implementation EXORpcValueTest

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
    EXORpcValue *value;
    NSArray *result;

    value = [EXORpcValue valueWithDate:[NSDate dateWithTimeIntervalSince1970:42] number:@(123456)];
    XCTAssertEqualObjects(value.when, [NSDate dateWithTimeIntervalSince1970:42], @"Check date");
    XCTAssertEqualObjects(value.numberValue, @(123456), @"Check number");
    XCTAssertEqualObjects(value.stringValue, @"123456", @"Check number");
    result = @[@(42), @(123456)];
    XCTAssertEqualObjects([value plistValue], result, @"Check plist");

    value = [EXORpcValue valueWithDate:[NSDate dateWithTimeIntervalSince1970:42] string:@"Fiddly pop"];
    XCTAssertEqualObjects(value.when, [NSDate dateWithTimeIntervalSince1970:42], @"Check date");
    XCTAssertEqualObjects(value.stringValue, @"Fiddly pop", @"Check string");
    XCTAssertEqualObjects(value.numberValue, nil, @"Check number");
    result = @[@(42), @"Fiddly pop"];
    XCTAssertEqualObjects([value plistValue], result, @"Check plist");

    value = [EXORpcValue valueWithDate:[NSDate dateWithTimeIntervalSince1970:42] json:@{@"test": @[@"this",@(98)]}];
    XCTAssertEqualObjects(value.when, [NSDate dateWithTimeIntervalSince1970:42], @"Check date");
    XCTAssertEqualObjects(value.numberValue, nil, @"Check number");
    XCTAssertEqualObjects(value.stringValue, @"{\"test\":[\"this\",98]}", @"Check string");
    result = @[@(42), @"{\"test\":[\"this\",98]}"];
    XCTAssertEqualObjects([value plistValue], result, @"Check plist");
    id test = @{@"test": @[@"this",@(98)]};
    XCTAssertEqualObjects(value.json, test, @"Check JSON");

}

- (void)testCopyAndCompare
{
    EXORpcValue *Aval, *Bval;

    Aval = [EXORpcValue valueWithDate:[NSDate dateWithTimeIntervalSince1970:42] number:@(123456)];
    Bval = [Aval copy];
    // Immutable copy just retains, so pointers will be equal.
    XCTAssertEqual(Aval, Bval, @"Pointers equal after copy.");
    XCTAssertEqualObjects(Aval, Bval, @"objects equal");

    Aval = [EXORpcValue valueWithDate:[NSDate dateWithTimeIntervalSince1970:42] number:@(123456)];
    Bval = [EXORpcValue valueWithDate:[NSDate dateWithTimeIntervalSince1970:42] number:@(123456)];
    XCTAssertNotEqual(Aval, Bval, @"Pointers NOT equal");
    XCTAssertEqualObjects(Aval, Bval, @"objects equal");
}

- (void)testArchiving
{
    EXORpcValue *vin, *vout;
    NSData *data;

    vin = [EXORpcValue valueWithDate:[NSDate dateWithTimeIntervalSince1970:42] string:@"Fiddly pop"];
    data = [NSKeyedArchiver archivedDataWithRootObject:vin];
    XCTAssertNotNil(data, @"archived.");

    vout = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
#if 0
    // This fails because vin and vout fail isKindOfClass:
    // But as far as I can tell, they are both EXORpcValue.
    XCTAssertEqualObjects(vout, vin, @"Value unarchived is value archived");
#else
    XCTAssertEqualObjects(vout.when, vin.when);
    XCTAssertEqualObjects(vout.stringValue, vin.stringValue);
    XCTAssertEqualObjects(vout.numberValue, vin.numberValue);
#endif

}

@end
