//
//  EXOPortalNewDevice.m
//
//  Created by Michael Conrad Tadpol Tilstra on 3/14/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOPortalNewDevice.h"

@interface EXOPortalNewDevice ()
@property(copy, nonatomic) NSString *portal_rid;
@property(copy, nonatomic) NSString *vendor;
@property(copy, nonatomic) NSString *model;
@property(copy, nonatomic) NSString *serialNumber;
@property(copy, nonatomic) NSString *name;
@property(copy, nonatomic) NSString *timezone;
@property(copy, nonatomic) NSString *location;
@end

@implementation EXOPortalNewDevice

+ (EXOPortalNewDevice *)deviceWithPortalRid:(NSString *)portal_rid vendor:(NSString *)vendor serialNumber:(NSString *)serialNumber name:(NSString *)name timezone:(NSString *)timezone location:(NSString *)location
{
    return [[EXOPortalNewDevice alloc] initWithPortalRid:portal_rid vendor:vendor serialNumber:serialNumber name:name timezone:timezone location:location];
}

+ (EXOPortalNewDevice *)deviceWithPortalRid:(NSString *)portal_rid vendor:(NSString *)vendor serialNumber:(NSString *)serialNumber name:(NSString *)name
{
    return [[EXOPortalNewDevice alloc] initWithPortalRid:portal_rid vendor:vendor serialNumber:serialNumber name:name timezone:nil location:nil];
}

- (id)init
{
    return nil;
}

- (instancetype)initWithPortalRid:(NSString *)portal_rid vendor:(NSString *)vendor serialNumber:(NSString *)serialNumber name:(NSString *)name timezone:(NSString *)timezone location:(NSString *)location
{
    if (self = [super init]) {
        self.portal_rid = portal_rid;
        self.vendor = vendor;
        self.serialNumber = serialNumber;
        self.name = name;
        self.timezone = timezone;
        self.location = location;
    }
    return self;
}

- (id)plistValue
{
    NSMutableDictionary *ret = [NSMutableDictionary new];
    ret[@"portal_rid"] = self.portal_rid;
    ret[@"vendor"] = self.vendor;
    ret[@"serialnumber"] = self.serialNumber;
    ret[@"name"] = self.name;
    if (self.timezone) {
        ret[@"timezone"] = self.timezone;
    }
    if (self.location) {
        ret[@"location"] = self.location;
    }
    
    return [ret copy];
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    EXOPortalNewDevice *obj = (EXOPortalNewDevice*)object;
    return ([self.portal_rid isEqual:obj.portal_rid] &&
            [self.vendor isEqual:obj.vendor] &&
            [self.serialNumber isEqual:obj.serialNumber] &&
            [self.name isEqual:obj.name] &&
            [self.timezone isEqual:obj.timezone] &&
            [self.location isEqual:obj.location]
            );
}

- (NSUInteger)hash
{
    return (self.portal_rid.hash ^ self.vendor.hash ^ self.serialNumber.hash ^ self.name.hash ^ self.timezone.hash ^ self.location.hash);
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p, portal_rid: %@ vendor: %@ serialNumber: %@ name: %@ timezone: %@ location: %@ >", NSStringFromClass([self class]), self, self.portal_rid, self.vendor, self.serialNumber, self.name, self.timezone, self.location];
}

@end
