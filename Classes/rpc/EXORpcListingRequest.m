//
//  EXORpcListingRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcListingRequest.h"

@interface EXORpcListingRequest ()
@property(nonatomic,assign) EXORpcListType_t list;
@property(nonatomic,assign) EXORpcFilterType_t filter;
@property(nonatomic,copy) EXORpcListingRequestComplete complete;

@end

@implementation EXORpcListingRequest

+ (EXORpcListingRequest *)listingByType:(EXORpcListType_t)list filter:(EXORpcFilterType_t)filter complete:(EXORpcListingRequestComplete)complete
{
    return [[EXORpcListingRequest alloc] initWithType:list filter:filter complete:complete];
}

- (instancetype)initWithType:(EXORpcListType_t)list filter:(EXORpcFilterType_t)filter complete:(EXORpcListingRequestComplete)complete
{
    if (self = [super init]) {
        self.list = list;
        self.filter = filter;
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
    NSMutableArray *types = [NSMutableArray arrayWithCapacity:4];
    if (self.list & EXORpcListTypeClient) {
        [types addObject:@"client"];
    }
    if (self.list & EXORpcListTypeDataport) {
        [types addObject:@"dataport"];
    }
    if (self.list & EXORpcListTypeDatarule) {
        [types addObject:@"datarule"];
    }
    if (self.list & EXORpcListTypeDispatch) {
        [types addObject:@"dispatch"];
    }
    
    NSMutableDictionary *filters = [NSMutableDictionary dictionary];
    if (self.filter & EXORpcFilterTypeActivated) {
        filters[@"activated"] = @YES;
    }
    if (self.filter & EXORpcFilterTypeAliased) {
        filters[@"aliased"] = @YES;
    }
    if (self.filter & EXORpcFilterTypeOwned) {
        filters[@"owned"] = @YES;
    }
    if (self.filter & EXORpcFilterTypePublic) {
        filters[@"public"] = @YES;
    }
    // FIXME: tags are actually an array of strings.
#if 0
    if (self.filter & EXORpcFilterTypeTagged) {
        filters[@"tagged"] = @"true";
    }
#endif
    
    return @{@"procedure": @"listing", @"arguments": @[[types copy], [filters copy]]};
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    EXORpcListingRequest *obj = (EXORpcListingRequest*)object;
    return [self.rid isEqual:obj.rid ] && self.list == obj.list && self.filter == obj.filter;
}

- (NSUInteger)hash
{
    return self.rid.hash ^ self.list ^ self.filter;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

@end
