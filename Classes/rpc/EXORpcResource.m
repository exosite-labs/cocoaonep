//
//  EXORpcResource.m
//  CocoaOneP
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcResource.h"

@implementation EXORpcResource

- (NSArray *)plistValue
{
    return @[];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p, Type: %@, Name: %@, Meta: %@>", NSStringFromClass([self class]), self, self.type, self.name, self.meta];
}

@end
