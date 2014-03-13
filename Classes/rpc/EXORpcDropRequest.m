//
//  EXORpcDropRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcDropRequest.h"

@interface EXORpcDropRequest ()
@property(nonatomic,copy) EXORpcRequestComplete complete;
@end

@implementation EXORpcDropRequest

+ (EXORpcDropRequest *)dropWithRID:(EXORpcResourceID *)rid complete:(EXORpcRequestComplete)complete
{
    return [[EXORpcDropRequest alloc] initWithRID:rid complete:complete];
}

- (instancetype)initWithRID:(EXORpcResourceID *)rid complete:(EXORpcRequestComplete)complete
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
