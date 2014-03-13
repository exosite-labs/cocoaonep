//
//  EXOOnePMapRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcMapRequest.h"

@implementation EXORpcMapRequest


- (void)doResult:(NSDictionary *)result error:(NSError *)error
{
    if (self.complete) {
        NSError *err = [self errorFromStatus:result];
        if (err) {
            self.complete(err);
        } else {
            self.complete(nil);
        }
    }
}

- (NSDictionary *)plistValue
{
    return @{ @"procedure": @"map", @"arguments": @[@"alias", [self.rid plistValue], self.aliasName]};
}

@end
