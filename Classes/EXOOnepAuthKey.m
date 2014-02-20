//
//  EXOOnepAuthKey.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepAuthKey.h"

@interface EXOOnepAuthKey ()
@property(copy) NSString *CIK;
@end

@implementation EXOOnepAuthKey

+ (EXOOnepAuthKey *)authWithCIK:(NSString *)cik
{
    return [[EXOOnepAuthKey alloc] initWithCIK:cik];
}

- (instancetype)init
{
    return nil;
}

- (instancetype)initWithCIK:(NSString *)cik
{
    if (self = [super init]) {
        self.CIK = cik;
    }
    return self;
}

- (NSDictionary *)plistValue
{
    return @{@"cik": self.CIK};
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p, CIK: %@>", NSStringFromClass([self class]), self, self.CIK];
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    return [self.CIK isEqualToString:[object CIK]];
}

- (NSUInteger)hash
{
    return self.CIK.hash;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

@end
