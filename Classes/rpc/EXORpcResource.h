//
//  EXORpcResource.h
//  CocoaOneP
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EXORpcResourceID.h"
#import "EXORpcResourceRetention.h"

@interface EXORpcResource : NSObject <NSCopying>
@property(copy,nonatomic,readonly) NSString *meta;
@property(copy,nonatomic,readonly) NSString *name;
@property(copy,nonatomic,readonly) NSString *type;
@property(assign,nonatomic,readonly) BOOL public;

+ (EXORpcResource*)resourceWithName:(NSString*)name meta:(NSString*)meta public:(BOOL)public;
+ (EXORpcResource*)resourceWithName:(NSString*)name meta:(NSString*)meta;
- (instancetype)initWithName:(NSString*)name meta:(NSString*)meta public:(BOOL)public;
- (instancetype)initWithName:(NSString*)name meta:(NSString*)meta;

- (id)plistValue;
@end
