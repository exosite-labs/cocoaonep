//
//  EXOPortalNewUser.h
//
//  Created by Michael Conrad Tadpol Tilstra on 3/14/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EXOPortalNewUser : NSObject <NSCopying>
@property(copy,nonatomic,readonly) NSString* email;
@property(copy,nonatomic,readonly) NSString* password;
@property(copy,nonatomic,readonly) NSString* plan;
@property(copy,nonatomic,readonly) NSString* firstName;
@property(copy,nonatomic,readonly) NSString* lastName;

+ (EXOPortalNewUser*)userWithEmail:(NSString*)email password:(NSString*)password plan:(NSString*)plan;
+ (EXOPortalNewUser*)userWithEmail:(NSString*)email password:(NSString*)password plan:(NSString*)plan firstName:(NSString*)firstName lastName:(NSString*)lastName;

- (instancetype)initWithEmail:(NSString*)email password:(NSString*)password plan:(NSString*)plan firstName:(NSString*)firstName lastName:(NSString*)lastName;

- (id)plistValue;

@end
