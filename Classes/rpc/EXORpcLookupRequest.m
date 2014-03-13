//
//  EXORpcLookupRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcLookupRequest.h"

@implementation EXORpcLookupRequest

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
        case EXORpcLookupTypeAlias:
            which = @"alias";
            break;
        case EXORpcLookupTypeOwner:
            which = @"owner";
            break;
        case EXORpcLookupTypeShared:
            which = @"shared";
            break;
    }
    return @{@"procedure": @"lookup", @"arguments": @[which, self.item]};
}

@end
