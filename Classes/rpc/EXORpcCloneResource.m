//
//  EXORpcCreateCloneRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcCloneResource.h"

@implementation EXORpcCloneResource

- (NSString *)type
{
    return @"clone";
}

- (NSDictionary *)plistValue
{
    return @{@"rid": [self.rid plistValue], @"code": self.code, @"noaliases": @(self.noaliases), @"nohistorical": @(self.nohistorical)};
}
@end
