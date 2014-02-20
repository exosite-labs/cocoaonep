//
//  EXOOnepCreateRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepCreateRequest.h"

@implementation EXOOnepCreateRequest

- (NSDictionary *)plistValue
{
    return @{@"procedure": @"create", @"arguments": self.resource};
}

- (void)doResult:(NSDictionary *)result error:(NSError *)error
{
    if (self.complete) {
        NSError *err = [self errorFromStatus:result];
        if (err) {
            self.complete(nil, err);
        } else {
            NSString *rid = result[@"result"]; // FIXME: Add type checking.
            EXOOnepResourceID *trid = [EXOOnepResourceID resourceIDByRID:rid];
            self.complete(trid, nil);
        }
    }
}

@end
