//
//  EXOOnepLookupRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepLookupRequest.h"

@implementation EXOOnepLookupRequest

- (void)doResult:(NSDictionary *)result error:(NSError *)error
{
    if (self.complete) {
        NSError *err = [self errorFromStatus:result];
        if (err) {
            self.complete(nil, err);
        } else {
            self.complete(result[@"result"], nil);
        }
    }
}

- (NSDictionary *)plistValue
{
    NSString *which;
    switch (self.type) {
        default:
        case EXOOnepLookupTypeAlias:
            which = @"alias";
            break;
        case EXOOnepLookupTypeOwner:
            which = @"owner";
            break;
        case EXOOnepLookupTypeShared:
            which = @"shared";
            break;
    }
    return @{@"procedure": @"lookup", @"arguments": @[which, self.item]};
}

@end
