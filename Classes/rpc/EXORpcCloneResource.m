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

+ (EXORpcCloneResource *)cloneWithCode:(NSString *)code noaliases:(BOOL)noaliases nohistorical:(BOOL)nohistorical
{
    return [[EXORpcCloneResource alloc] initWithCode:code noaliases:noaliases nohistorical:nohistorical];
}

+ (EXORpcCloneResource *)cloneWithRid:(EXORpcResourceID *)rid noaliases:(BOOL)noaliases nohistorical:(BOOL)nohistorical
{
    return [[EXORpcCloneResource alloc] initWithRid:rid noaliases:noaliases nohistorical:nohistorical];
}

- (id)init
{
    return nil;
}

- (instancetype)initWithCode:(NSString *)code noaliases:(BOOL)noaliases nohistorical:(BOOL)nohistorical
{
    if (self = [super initWithName:nil meta:nil public:NO]) {
        _rid = nil;
        _code = [code copy];
        _noaliases = noaliases;
        _nohistorical = nohistorical;
    }
    return self;
}

- (instancetype)initWithRid:(EXORpcResourceID *)rid noaliases:(BOOL)noaliases nohistorical:(BOOL)nohistorical
{
    /* Must be a RID type, not an alias type. */
    if (rid.rid == nil) {
        return nil;
    }
    if (self = [super initWithName:nil meta:nil public:NO]) {
        _rid = [rid copy];
        _code = nil;
        _noaliases = noaliases;
        _nohistorical = nohistorical;
    }
    return self;
}
- (NSString *)type
{
    return @"clone";
}

- (NSDictionary *)plistValue
{
    if (self.rid) {
        return @{@"rid": self.rid.rid, @"noaliases": @(self.noaliases), @"nohistorical": @(self.nohistorical)};
    } else {
        return @{@"code": self.code, @"noaliases": @(self.noaliases), @"nohistorical": @(self.nohistorical)};
    }
}

@end
