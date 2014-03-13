//
//  EXORpcResourceID.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EXORpcResourceID : NSObject <NSCopying>

+ (EXORpcResourceID*)resourceIDByAlias:(NSString*)alias;
+ (EXORpcResourceID*)resourceIDByRID:(NSString*)rid;
+ (EXORpcResourceID*)resourceIDAsSelf;

- (instancetype)init;
- (instancetype)initWithAlias:(NSString*)alias;
- (instancetype)initWithRID:(NSString*)rid;

- (id)plistValue;
@end
