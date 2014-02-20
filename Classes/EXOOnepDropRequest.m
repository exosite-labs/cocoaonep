//
//  EXOOnepDropRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepDropRequest.h"

@interface EXOOnepDropRequest ()
@property(nonatomic,copy) EXOOnepRequestComplete complete;
@end

@implementation EXOOnepDropRequest

+ (EXOOnepDropRequest *)dropWithRID:(EXOOnepResourceID *)rid complete:(EXOOnepRequestComplete)complete
{
    return [[EXOOnepDropRequest alloc] initWithRID:rid complete:complete];
}

- (instancetype)initWithRID:(EXOOnepResourceID *)rid complete:(EXOOnepRequestComplete)complete
{
    if (self = [super initWithRID:rid]) {
        self.complete = complete;
    }
    return self;
}

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
    return @{ @"procedure": @"drop", @"arguments": @[[self.rid plistValue]]};
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

@end
