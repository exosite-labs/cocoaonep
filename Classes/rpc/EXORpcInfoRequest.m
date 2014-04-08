//
//  EXORpcInfoRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcInfoRequest.h"

@interface EXORpcInfoRequest ()
@property(nonatomic,assign) EXORpcInfoRequestTypes_t types;
@property(nonatomic,copy) EXORpcInfoRequestComplete complete;
@end


@implementation EXORpcInfoRequest

+ (EXORpcInfoRequest *)infoByRID:(EXORpcResourceID *)rid types:(EXORpcInfoRequestTypes_t)types complete:(EXORpcInfoRequestComplete)complete
{
    return [[EXORpcInfoRequest alloc] initWithRID:rid types:types complete:complete];
}

- (instancetype)initWithRID:(EXORpcResourceID *)rid types:(EXORpcInfoRequestTypes_t)types complete:(EXORpcInfoRequestComplete)complete
{
    if (self = [super initWithRID:rid]) {
        self.types = types;
        self.complete = complete;
    }
    return self;
}

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

- (NSDictionary *)plistValue
{
    NSMutableDictionary *args = [NSMutableDictionary new];
    if (self.types & EXORpcInfoRequestTypeAliases) {
        args[@"aliases"] = @YES;
    }
    if (self.types & EXORpcInfoRequestTypeBasic) {
        args[@"basic"] = @YES;
    }
    if (self.types & EXORpcInfoRequestTypeComments) {
        args[@"comments"] = @YES;
    }
    if (self.types & EXORpcInfoRequestTypeCounts) {
        args[@"counts"] = @YES;
    }
    if (self.types & EXORpcInfoRequestTypeDescription) {
        args[@"description"] = @YES;
    }
    if (self.types & EXORpcInfoRequestTypeKey) {
        args[@"key"] = @YES;
    }
    if (self.types & EXORpcInfoRequestTypeShares) {
        args[@"shares"] = @YES;
    }
    if (self.types & EXORpcInfoRequestTypeTagged) {
        args[@"tagged"] = @YES;
    }
    if (self.types & EXORpcInfoRequestTypeTags) {
        args[@"tags"] = @YES;
    }
    if (self.types & EXORpcInfoRequestTypeUsage) {
        args[@"usage"] = @YES;
    }

    return @{@"procedure": @"info", @"arguments": @[[self.rid plistValue], [args copy]]};
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    return self.types == [(EXORpcInfoRequest*)object types] && [self.rid isEqual:[object rid]];
}

- (NSUInteger)hash
{
    return self.types ^ self.rid.hash;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

@end
