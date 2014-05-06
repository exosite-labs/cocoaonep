//
//  EXORpcValue.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EXORpcValue : NSObject <NSCopying>
@property(copy,nonatomic,readonly) NSDate *when;
@property(copy,nonatomic,readonly) NSString *stringValue;
@property(copy,nonatomic,readonly) NSNumber *numberValue;

+ (EXORpcValue*)valueWithDate:(NSDate*)when string:(NSString*)value;
+ (EXORpcValue*)valueWithDate:(NSDate*)when number:(NSNumber*)value;

- (instancetype)initWithDate:(NSDate*)when string:(NSString*)value;
- (instancetype)initWithDate:(NSDate*)when number:(NSNumber*)value;

@end
