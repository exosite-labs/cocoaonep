//
//  EXOWebSocket.m
//  Pods
//
//  Created by Michael Conrad Tadpol Tilstra on 10/29/15.
//
//

#import "EXOWebSocket.h"
#import "SRWebSocket.h"

static NSString *EXORpcAPIPath = @"/api:v1/rpc/process";

@interface EXOWebSocket ()
@property (copy,nonatomic) NSURL *domain;
@end

@implementation EXOWebSocket

- (instancetype)initWithDomain:(NSURL *)domain {
    if ([super init]) {
        if (domain) {
            _domain = [domain copy];
        } else {
            _domain = [NSURL URLWithString:@"https://m2.exosite.com/"];
        }
    }
    return self;
}

- (instancetype)init {
    return [self initWithDomain:nil];
}

@end
