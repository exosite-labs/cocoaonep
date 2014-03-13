//
//  EXOPortalAuth.h
//
//  Created by Michael Conrad Tadpol Tilstra on 3/13/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//
//

#import <Foundation/Foundation.h>

@interface EXOPortalAuth : NSObject <NSCopying>
@property(copy,nonatomic,readonly) NSString *username;
@property(copy,nonatomic,readonly) NSString *password;

+ (EXOPortalAuth*)authWithUsername:(NSString*)username password:(NSString*)password;

- (instancetype)initWithUsername:(NSString*)username password:(NSString*)password;

@end
