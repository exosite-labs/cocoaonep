//
//  EXORpcInfoRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcInfoRequest.h"
#import "EXORpcClientResource.h"
#import "EXORpcDataportResource.h"
#import "EXORpcDataruleResource.h"
#import "EXORpcDispatchResource.h"

@interface EXORpcInfoRequest ()
@property(nonatomic,assign) EXORpcInfoRequestTypes_t types;
@property(nonatomic,copy) EXORpcInfoRequestComplete complete;
@property(assign,nonatomic) BOOL returnRaw;
@property(assign,nonatomic) BOOL maskedBasicInfo;
@end


@implementation EXORpcInfoRequest

+ (EXORpcInfoRequest *)infoByRID:(EXORpcResourceID *)rid types:(EXORpcInfoRequestTypes_t)types complete:(EXORpcInfoRequestComplete)complete
{
    return [[EXORpcInfoRequest alloc] initWithRID:rid types:types raw:NO complete:complete];
}

- (instancetype)initWithRID:(EXORpcResourceID *)rid types:(EXORpcInfoRequestTypes_t)types raw:(BOOL)raw complete:(EXORpcInfoRequestComplete)complete
{
    if (self = [super initWithRID:rid]) {
        _types = types;
        _returnRaw = raw;
        _complete = [complete copy];
    }
    return self;
}

- (void)doResult:(NSDictionary *)result
{
    if (self.complete) {
        NSError *err = [self errorFromStatus:result];
        if (err) {
            self.complete(nil, err);
        } else {
            if (self.returnRaw) {
                self.complete(result[@"result"], nil);
                return;
            }

            NSMutableDictionary *mres = [result[@"result"] mutableCopy];

            if (mres[@"description"] && mres[@"basic"] && mres[@"basic"][@"type"]) {
                NSString *type = mres[@"basic"][@"type"];
                if ([type isEqualToString:@"client"]) {
                    mres[@"description"] = [[EXORpcClientResource alloc] initWithPList:mres[@"description"]];
                } else if ([type isEqualToString:@"dataport"]) {
                    mres[@"description"] = [[EXORpcDataportResource alloc] initWithPList:mres[@"description"]];
                } else if ([type isEqualToString:@"datarule"]) {
                    mres[@"description"] = [[EXORpcDataruleResource alloc] initWithPList:mres[@"description"]];
                } else if ([type isEqualToString:@"dispatch"]) {
                    mres[@"description"] = [[EXORpcDispatchResource alloc] initWithPList:mres[@"description"]];
                }
            }

            if (self.maskedBasicInfo) {
                [mres removeObjectForKey:@"basic"];
            }
            self.complete([mres copy], nil);
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
    } else if(!self.returnRaw && (self.types & EXORpcInfoRequestTypeDescription)) {
        self.maskedBasicInfo = YES;
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
