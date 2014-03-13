//
//  EXOPortalPortal.h
//
//  Created by Michael Conrad Tadpol Tilstra on 3/13/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EXOPortalPortal : NSObject <NSCopying>
@property(copy,nonatomic,readonly) NSString *name;
@property(copy,nonatomic,readonly) NSString *domain;
@property(copy,nonatomic,readonly) NSString *role;
@property(copy,nonatomic,readonly) NSString *key;
@property(copy,nonatomic,readonly) NSString *rid;

+ (EXOPortalPortal*)portalWithDictionary:(NSDictionary*)dict;

+ (EXOPortalPortal*)portalWithName:(NSString*)name domain:(NSString*)domain role:(NSString*)role key:(NSString*)key rid:(NSString*)rid;

- (instancetype)initWithName:(NSString*)name domain:(NSString*)domain role:(NSString*)role key:(NSString*)key rid:(NSString*)rid;

@end
