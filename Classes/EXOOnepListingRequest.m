//
//  EXOOnepListingRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepListingRequest.h"

@interface EXOOnepListingRequest ()
@property(nonatomic,assign) EXOOnepListType_t list;
@property(nonatomic,assign) EXOOnepFilterType_t filter;
@property(nonatomic,copy) EXOOnepListingRequestComplete complete;

@end

@implementation EXOOnepListingRequest

+ (EXOOnepListingRequest *)listingByRID:(EXOOnepResourceID *)rid list:(EXOOnepListType_t)list filter:(EXOOnepFilterType_t)filter complete:(EXOOnepListingRequestComplete)complete
{
    return [[EXOOnepListingRequest alloc] initWithRID:rid list:list filter:filter complete:complete];
}

- (instancetype)initWithRID:(EXOOnepResourceID *)rid list:(EXOOnepListType_t)list filter:(EXOOnepFilterType_t)filter complete:(EXOOnepListingRequestComplete)complete
{
    if (self = [super init]) {
        self.rid = rid;
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

- (void)doResult:(NSDictionary *)result error:(NSError *)error
{
    if (self.complete) {
        NSError *err = [self errorFromStatus:result];
        if (err) {
            self.complete(nil, err);
        } else {
            // TODO: results is array "in order of requested", Want to map that to a dictionary with the parts named.
            NSArray *Aret = result[@"result"];
            // ??? is the array always four items?
            NSMutableDictionary *Dret = [NSMutableDictionary dictionaryWithCapacity:4];
            if (self.list & EXOOnepListTypeClient) {
                Dret[@"client"] = Aret[0];
            }
            if (self.list & EXOOnepListTypeDataport) {
                Dret[@"dataport"] = Aret[1];
            }
            if (self.list & EXOOnepListTypeDatarule) {
                Dret[@"datarule"] = Aret[2];
            }
            if (self.list & EXOOnepListTypeDispatch) {
                Dret[@"dispatch"] = Aret[3];
            }

            self.complete([Dret copy], nil);
        }
    }
}

- (NSDictionary *)plistValue
{
    NSMutableArray *types = [NSMutableArray arrayWithCapacity:4];
    if (self.list & EXOOnepListTypeClient) {
        [types addObject:@"client"];
    }
    if (self.list & EXOOnepListTypeDataport) {
        [types addObject:@"dataport"];
    }
    if (self.list & EXOOnepListTypeDatarule) {
        [types addObject:@"datarule"];
    }
    if (self.list & EXOOnepListTypeDispatch) {
        [types addObject:@"dispatch"];
    }
    
    NSMutableArray *filters = [NSMutableArray arrayWithCapacity:5];
    if (self.filter & EXOOnepFilterTypeActivated) {
        [filters addObject:@"activated"];
    }
    if (self.filter & EXOOnepFilterTypeAliased) {
        [filters addObject:@"aliased"];
    }
    if (self.filter & EXOOnepFilterTypeOwned) {
        [filters addObject:@"owned"];
    }
    if (self.filter & EXOOnepFilterTypePublic) {
        [filters addObject:@"public"];
    }
    if (self.filter & EXOOnepFilterTypeTagged) {
        [filters addObject:@"tagged"];
    }
    
    return @{@"procedure": @"listing", @"arguments": @[[types copy], [filters copy]]};
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    EXOOnepListingRequest *obj = (EXOOnepListingRequest*)object;
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
