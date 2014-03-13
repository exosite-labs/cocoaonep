//
//  EXOPortalDomain.h
//
//  Created by Michael Conrad Tadpol Tilstra on 3/13/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EXOPortalDomain : NSObject
@property(copy,nonatomic,readonly) NSString *role;
@property(copy,nonatomic,readonly) NSString *name;
@property(copy,nonatomic,readonly) NSString *domain;

+ (EXOPortalDomain*)domainWithRole:(NSString*)role name:(NSString*)name domain:(NSString*)domain;

+ (EXOPortalDomain*)domainWithDictionary:(NSDictionary*)dict;

- (instancetype)initWithRole:(NSString*)role name:(NSString*)name domain:(NSString*)domain;

@end
