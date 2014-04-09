//
//  EXORpcCreateCloneRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcCloneResource.h"

@interface EXORpcCloneResource ()
@property(copy,nonatomic) EXORpcResourceID *rid;
@property(copy,nonatomic) NSString *code;
@property(assign,nonatomic) BOOL noaliases;
@property(assign,nonatomic) BOOL nohistorical;
@end

@implementation EXORpcCloneResource

+ (EXORpcCloneResource *)resrouceWithName:(NSString *)name meta:(NSString *)meta public:(BOOL)public rid:(EXORpcResourceID *)rid code:(NSString *)code noaliases:(BOOL)noaliases nohistorical:(BOOL)nohistorical
{
    return [[EXORpcCloneResource alloc] initWithName:name meta:meta public:public rid:rid code:code noaliases:noaliases nohistorical:nohistorical];
}

+ (EXORpcCloneResource *)resrouceWithName:(NSString *)name meta:(NSString *)meta rid:(EXORpcResourceID *)rid code:(NSString *)code
{
    return [[EXORpcCloneResource alloc] initWithName:name meta:meta public:YES rid:rid code:code noaliases:NO nohistorical:NO];
}

- (id)init
{
    return nil;
}

- (id)initWithName:(NSString *)name meta:(NSString *)meta public:(BOOL)public rid:(EXORpcResourceID *)rid code:(NSString *)code noaliases:(BOOL)noaliases nohistorical:(BOOL)nohistorical
{
    if (self = [super initWithName:name meta:meta public:public]) {
        self.rid = rid;
        self.code = code;
        self.noaliases = noaliases;
        self.nohistorical = nohistorical;
    }
    return self;
}

- (NSString *)type
{
    return @"clone";
}

- (NSDictionary *)plistValue
{
    return @{@"rid": [self.rid plistValue], @"code": self.code, @"noaliases": @(self.noaliases), @"nohistorical": @(self.nohistorical)};
}

@end
