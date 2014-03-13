//
//  EXOOnepInfoRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepInfoRequest.h"

@interface EXOOnepInfoRequest ()
@property(nonatomic,assign) EXOOnepInfoRequestTypes_t types;
@property(nonatomic,copy) EXOOnepInfoRequestComplete complete;
@end


@implementation EXOOnepInfoRequest

+ (EXOOnepInfoRequest *)infoByRID:(EXOOnepResourceID *)rid types:(EXOOnepInfoRequestTypes_t)types complete:(EXOOnepInfoRequestComplete)complete
{
    return [[EXOOnepInfoRequest alloc] initWithRID:rid types:types complete:complete];
}

- (instancetype)initWithRID:(EXOOnepResourceID *)rid types:(EXOOnepInfoRequestTypes_t)types complete:(EXOOnepInfoRequestComplete)complete
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
    if (self.types & EXOOnepInfoRequestTypeAliases) {
        args[@"aliases"] = @"true";
    }
    if (self.types & EXOOnepInfoRequestTypeBasic) {
        args[@"basic"] = @"true";
    }
    if (self.types & EXOOnepInfoRequestTypeComments) {
        args[@"comments"] = @"true";
    }
    if (self.types & EXOOnepInfoRequestTypeCounts) {
        args[@"counts"] = @"true";
    }
    if (self.types & EXOOnepInfoRequestTypeDescription) {
        args[@"description"] = @"true";
    }
    if (self.types & EXOOnepInfoRequestTypeKey) {
        args[@"key"] = @"true";
    }
    if (self.types & EXOOnepInfoRequestTypeShares) {
        args[@"shares"] = @"true";
    }
    if (self.types & EXOOnepInfoRequestTypeTagged) {
        args[@"tagged"] = @"true";
    }
    if (self.types & EXOOnepInfoRequestTypeTags) {
        args[@"tags"] = @"true";
    }
    if (self.types & EXOOnepInfoRequestTypeUsage) {
        args[@"usage"] = @"true";
    }

    return @{@"procedure": @"info", @"arguments": @[[self.rid plistValue], [args copy]]};
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    return self.types == [object types];
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
