//
//  EXOOnepResourceID.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EXOOnepResourceID : NSObject <NSCopying>

+ (EXOOnepResourceID*)resourceIDByAlias:(NSString*)alias;
+ (EXOOnepResourceID*)resourceIDByRID:(NSString*)rid;
+ (EXOOnepResourceID*)resourceIDAsSelf;

- (instancetype)init;
- (instancetype)initWithAlias:(NSString*)alias;
- (instancetype)initWithRID:(NSString*)rid;

- (id)plistValue;
@end
