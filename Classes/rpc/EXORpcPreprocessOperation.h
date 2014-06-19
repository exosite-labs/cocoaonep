//
//  EXORpcPreprocessOperation.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    EXORpcPreprocessOperation_Add,
    EXORpcPreprocessOperation_Subtract,
    EXORpcPreprocessOperation_Multiply,
    EXORpcPreprocessOperation_Divide,
    EXORpcPreprocessOperation_Modulo,
    EXORpcPreprocessOperation_GreaterThan,
    EXORpcPreprocessOperation_GreaterThanOrEqual,
    EXORpcPreprocessOperation_LessThan,
    EXORpcPreprocessOperation_LessThanOrEqual,
    EXORpcPreprocessOperation_Equal,
    EXORpcPreprocessOperation_NotEqual,
    EXORpcPreprocessOperation_Value,
} EXORpcPreprocessOperation_t;

/**
 A preprocess operation that added to dataports and datarules.
 */
@interface EXORpcPreprocessOperation : NSObject <NSCopying>

/**
 The operation to take
 */
@property(assign,nonatomic,readonly) EXORpcPreprocessOperation_t operation;

/**
 The constant to use with this operation
 */
@property(copy,nonatomic,readonly) NSNumber *value;

/**
 Create a preprocess step
 
 @param operation The operation to take
 @param value The constant to use
 @return A preprocess step
 */
+ (EXORpcPreprocessOperation*)preprocessOperation:(EXORpcPreprocessOperation_t)operation value:(NSNumber*)value;

/**
 Initialize a preprocess step

 @param operation The operation to take
 @param value The constant to use
 @return A preprocess step
 */
- (instancetype)initWithOperation:(EXORpcPreprocessOperation_t)operation value:(NSNumber*)value;

/**
 Return the resource as a JSON ready plist.
 */
- (NSArray*)plistValue;

@end
