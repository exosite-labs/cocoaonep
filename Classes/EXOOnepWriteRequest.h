//
//  EXOOnepWriteRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EXOOnepRequest.h"

@interface EXOOnepWriteRequest : EXOOnepRequest <NSCopying>
@property(nonatomic,strong,readonly) id value;
@property(nonatomic,copy,readonly) EXOOnepRequestComplete complete;

+ (EXOOnepWriteRequest*)writeWithRID:(EXOOnepResourceID*)rid string:(NSString*)value complete:(EXOOnepRequestComplete)complete;
+ (EXOOnepWriteRequest*)writeWithRID:(EXOOnepResourceID*)rid number:(NSNumber*)value complete:(EXOOnepRequestComplete)complete;
+ (EXOOnepWriteRequest*)writeWithRID:(EXOOnepResourceID*)rid plist:(id)value complete:(EXOOnepRequestComplete)complete;

- (instancetype)initWithRID:(EXOOnepResourceID*)rid value:(id)value complete:(EXOOnepRequestComplete)complete;

@end
