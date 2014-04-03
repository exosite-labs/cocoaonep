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
        args[@"aliases"] = @"true";
    }
    if (self.types & EXORpcInfoRequestTypeBasic) {
        args[@"basic"] = @"true";
    }
    if (self.types & EXORpcInfoRequestTypeComments) {
        args[@"comments"] = @"true";
    }
    if (self.types & EXORpcInfoRequestTypeCounts) {
        args[@"counts"] = @"true";
    }
    if (self.types & EXORpcInfoRequestTypeDescription) {
        args[@"description"] = @"true";
    }
    if (self.types & EXORpcInfoRequestTypeKey) {
        args[@"key"] = @"true";
    }
    if (self.types & EXORpcInfoRequestTypeShares) {
        args[@"shares"] = @"true";
    }
    if (self.types & EXORpcInfoRequestTypeTagged) {
        args[@"tagged"] = @"true";
    }
    if (self.types & EXORpcInfoRequestTypeTags) {
        args[@"tags"] = @"true";
    }
    if (self.types & EXORpcInfoRequestTypeUsage) {
        args[@"usage"] = @"true";
    }

    return @{@"procedure": @"info", @"arguments": @[[self.rid plistValue], [args copy]]};
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    return self.types == [(EXORpcInfoRequest*)object types];
}

- (NSUInteger)hash
{
    return self.types;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

@end
