//
//  EXOOnepInfoRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepInfoRequest.h"

@implementation EXOOnepInfoRequest

- (void)doResult:(NSDictionary *)result error:(NSError *)error
{
    if (self.complete) {
        NSError *err = [self errorFromStatus:result];
        if (err) {
            self.complete(nil, err);
        } else {
            self.complete(result[@"result"], nil); // FIXME: type check result.
        }
    }
}

- (NSDictionary *)asCall
{
#if 0
    // FIXME: Setting specific subsections to get info on fails to get replies. Getting everything works. Is this here or there at fault?
    return @{@"procedure": @"info", @"arguments": @[[self.rid asCall], @{
                                                        @"aliases": self.aliases?@"true":@"false",
                                                        @"basic": self.basic?@"true":@"false",
                                                        @"comments": self.comments?@"true":@"false",
                                                        @"counts": self.counts?@"true":@"false",
                                                        @"description": self.description?@"true":@"false",
                                                        @"key": self.key?@"true":@"false",
                                                        @"shares": self.shares?@"true":@"false",
                                                        @"tagged": self.tagged?@"true":@"false",
                                                        @"tags": self.tags?@"true":@"false",
                                                        @"usage": self.usage?@"true":@"false",
                                                        }]};
#else
    return @{@"procedure": @"info", @"arguments": @[[self.rid asCall], @{}]};
#endif
}

@end
