//
//  EXOWebSocketTest.m
//  CocoaOnePExample
//
//  Created by Michael Conrad Tadpol Tilstra on 11/3/15.
//  Copyright © 2015 Exosite. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AFNetworking.h"
#import <EXOWebSocket.h>

@interface EXOWebSocketTest : XCTestCase
@property (strong,nonatomic) NSString *tCIK;
@end

@implementation EXOWebSocketTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    XCTestExpectation *expectation = [self expectationWithDescription:@"Get test CIK"];
    AFHTTPSessionManager *mgr = [[AFHTTPSessionManager alloc] initWithBaseURL:nil];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    [mgr GET:@"https://cik.herokuapp.com" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSData *data = responseObject;
        self.tCIK = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"Using Test CIK %@", self.tCIK);
        [expectation fulfill];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        XCTFail(@"Failed to get CIK: %@", error);
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:30 handler:^(NSError * _Nullable error) {
        if (error) {
            XCTFail("Error waiting: %@", error);
        }
    }];

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInfo {
    EXORpcAuthKey *auth = [EXORpcAuthKey authWithCIK:self.tCIK];
    XCTAssertNotNil(auth);
    EXOWebSocket *ws = [[EXOWebSocket alloc] initWithAuth:auth onError:^(NSError *error){}];
    XCTAssertNotNil(ws);
    EXORpcResourceID *rid = [EXORpcResourceID resourceIDAsSelf];
    XCTestExpectation *expectation = [self expectationWithDescription:@"Info request returned"];
    EXORpcInfoRequest *ir = [EXORpcInfoRequest infoByRID:rid types:EXORpcInfoRequestTypeBasic complete:^(NSDictionary * _Nullable result, NSError * _Nullable error) {
        if (error) {
            XCTFail(@"returned with error: %@", error);
        }
        [expectation fulfill];
    }];
    [ws doCalls:@[ir] complete:^(NSError * _Nullable error) {
        if (error) {
            XCTFail(@"returned with error: %@", error);
            [expectation fulfill];
        }
    }];

    [self waitForExpectationsWithTimeout:60 handler:^(NSError * _Nullable error) {
        if (error) {
            XCTFail("Error waiting: %@", error);
        }
    }];
    [ws close];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
