//
//  EXOOnepShareRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepShareRequest.h"

@implementation EXOOnepShareRequest

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
    NSMutableDictionary *args = [NSMutableDictionary dictionaryWithCapacity:2];
    if (self.duration) {
        args[@"duration"] = @([self.duration timeIntervalSince1970]);
    } else {
        args[@"duration"] = @"infinity";
    }
    if (self.count) {
        args[@"count"] = self.count;
    }
    return @{ @"procedure": @"share", @"arguments": @[[self.rid plistValue], args]};
}
@end
