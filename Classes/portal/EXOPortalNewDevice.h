//
//  EXOPortalNewDevice.h
//
//  Created by Michael Conrad Tadpol Tilstra on 3/14/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EXOPortalNewDevice : NSObject <NSCopying>
@property(copy, nonatomic,readonly) NSString *portal_rid;
@property(copy, nonatomic,readonly) NSString *vendor;
@property(copy, nonatomic,readonly) NSString *model;
@property(copy, nonatomic,readonly) NSString *serialNumber;
@property(copy, nonatomic,readonly) NSString *name;
@property(copy, nonatomic,readonly) NSString *timezone;
@property(copy, nonatomic,readonly) NSString *location;

+ (EXOPortalNewDevice*)deviceWithPortalRid:(NSString*)portal_rid vendor:(NSString*)vendor model:(NSString*)model serialNumber:(NSString*)serialNumber name:(NSString*)name;

+ (EXOPortalNewDevice*)deviceWithPortalRid:(NSString*)portal_rid vendor:(NSString*)vendor model:(NSString*)model serialNumber:(NSString*)serialNumber name:(NSString*)name timezone:(NSString*)timezone location:(NSString*)location;

- (instancetype)initWithPortalRid:(NSString*)portal_rid vendor:(NSString*)vendor model:(NSString*)model serialNumber:(NSString*)serialNumber name:(NSString*)name timezone:(NSString*)timezone location:(NSString*)location;

- (id)plistValue;

@end
