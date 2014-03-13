//
//  EXORpcCreateCloneRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcCloneResource.h"

@implementation EXORpcCloneResource

- (NSArray *)plistValue
{
    return @[@"clone", @{@"rid": [self.rid plistValue], @"code": self.code, @"noaliases": @(self.noaliases), @"nohistorical": @(self.nohistorical)}];
}
@end
