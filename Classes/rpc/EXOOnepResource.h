//
//  EXOOnepResource.h
//  CocoaOneP
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EXOOnepResourceID.h"

@interface EXOOnepResource : NSObject
@property(copy) NSString *meta;
@property(copy) NSString *name;
@property(assign) BOOL public;

- (NSArray *)plistValue;
@end
