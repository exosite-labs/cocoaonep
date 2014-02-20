//
//  EXOOnepCreateCloneRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepCreateCloneRequest.h"

@implementation EXOOnepCreateCloneRequest

- (NSDictionary *)asCall
{
    return @{ @"procedure": @"create", @"arguments": @[@"clone", @{@"rid": [self.rid asCall], @"code": self.code, @"noaliases": @(self.noaliases), @"nohistorical": @(self.nohistorical)}]};
}
@end
