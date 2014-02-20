//
//  EXOOnepUnmapRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepUnmapRequest.h"

@implementation EXOOnepUnmapRequest

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

- (NSDictionary *)asCall
{
    return @{ @"procedure": @"unmap", @"arguments": @[@"alias", self.alias]};
}
@end
