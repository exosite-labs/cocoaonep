//
//  EXORpcActivateRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcActivateRequest.h"

@implementation EXORpcActivateRequest

- (void)doResult:(NSDictionary*)result error:(NSError*)error
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

- (NSDictionary*)plistValue
{
    return @{@"procedure": @"activate", @"arguments": @[(self.asShare?@"share":@"client"), self.code]};
}

@end
