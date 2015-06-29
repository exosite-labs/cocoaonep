//
//  EXORpcLookupRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcLookupRequest.h"

@interface EXORpcLookupRequest ()
@property(assign,nonatomic) EXORpcLookupType type;
@property(copy,nonatomic) NSString *item;
@property(copy,nonatomic) EXORpcLookupRequestComplete complete;
@end

@implementation EXORpcLookupRequest

+ (EXORpcLookupRequest *)lookupWithType:(EXORpcLookupType)type item:(NSString *)item complete:(EXORpcLookupRequestComplete)complete
{
    return [[EXORpcLookupRequest alloc] initWithType:type item:item complete:complete];
}

- (instancetype)initWithType:(EXORpcLookupType)type item:(NSString *)item complete:(EXORpcLookupRequestComplete)complete
{
    if (self = [super init]) {
        self.type = type;
        self.item = item;
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

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    EXORpcLookupRequest *obj = (EXORpcLookupRequest*)object;
    return self.type == obj.type && [self.item isEqualToString:obj.item];
}

- (NSUInteger)hash
{
    return self.item.hash ^ self.type;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

@end
