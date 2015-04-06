//
//  EXOOnePMapRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcMapRequest.h"

@interface EXORpcMapRequest ()
@property(strong,nonatomic) NSString *aliasName;
@property(copy,nonatomic) EXORpcRequestComplete complete;
@end

@implementation EXORpcMapRequest

+ (EXORpcMapRequest *)mapWithRID:(EXORpcResourceID *)rid to:(NSString *)alias complete:(EXORpcRequestComplete)complete
{
    return [[EXORpcMapRequest alloc] initWithRID:rid to:alias complete:complete];
}

- (instancetype)initWithRID:(EXORpcResourceID *)rid to:(NSString *)alias complete:(EXORpcRequestComplete)complete
{
    if (self = [super initWithRID:rid]) {
        self.aliasName = alias;
        self.complete = complete;
    }
    return self;
}

- (id)init
{
    return nil;
}

- (void)doResult:(NSDictionary *)result
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

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    EXORpcMapRequest *obj = (EXORpcMapRequest*)object;
    return [self.rid isEqual:obj.rid ] && [self.aliasName isEqualToString:obj.aliasName];
}

- (NSUInteger)hash
{
    return self.rid.hash ^ self.aliasName.hash;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

@end
