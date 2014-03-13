//
//  EXORpcWriteRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EXORpcRequest.h"

@interface EXORpcWriteRequest : EXORpcRequest <NSCopying>
@property(nonatomic,copy,readonly) NSString *value;
@property(nonatomic,copy,readonly) EXORpcRequestComplete complete;

+ (EXORpcWriteRequest*)writeWithRID:(EXORpcResourceID*)rid string:(NSString*)value complete:(EXORpcRequestComplete)complete;
+ (EXORpcWriteRequest*)writeWithRID:(EXORpcResourceID*)rid number:(NSNumber*)value complete:(EXORpcRequestComplete)complete;
+ (EXORpcWriteRequest*)writeWithRID:(EXORpcResourceID*)rid plist:(id)value complete:(EXORpcRequestComplete)complete;

- (instancetype)initWithRID:(EXORpcResourceID*)rid value:(NSString*)value complete:(EXORpcRequestComplete)complete;

@end
