//
//  EXORpcResource.h
//  CocoaOneP
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EXORpcResourceID.h"

@interface EXORpcResource : NSObject
@property(copy,nonatomic) NSString *meta;
@property(copy,nonatomic) NSString *name;
@property(copy,nonatomic,readonly) NSString *type;
@property(assign,nonatomic) BOOL public;

- (id)plistValue;
@end
