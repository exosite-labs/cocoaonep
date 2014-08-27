//
//  EXORpcPreprocessOperation.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EXORpcResourceID.h"

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
 A preprocess operation that is performed on incoming data to dataports, datarules, and dispatches.
 */
@interface EXORpcPreprocessOperation : NSObject <NSCopying>

/**
 The operation to take
 */
@property(assign,nonatomic,readonly) EXORpcPreprocessOperation_t operation;

/**
 The operation to take as a math symbol
 */
@property(copy,nonatomic,readonly) NSString *opSymbol;

/**
 The constant to use with this operation
 
 Might be nil if this step uses a RID to lookup the value.
 */
@property(copy,nonatomic,readonly) NSNumber *value;

/**
 The RID to lookup a value to use with this operation
 
 Might be nil if this step uses a constant value.
 */
@property(copy,nonatomic,readonly) EXORpcResourceID *rid;

/**
 Create a preprocess step
 
 @param operation The operation to take
 @param value The constant to use
 @return A preprocess step
 */
+ (EXORpcPreprocessOperation*)preprocessOperation:(EXORpcPreprocessOperation_t)operation value:(NSNumber*)value;

/**
 Create a preprocess step

 @param operation The operation to take
 @param rid A resource id to read for the value to use. Must be created with [EXORpcResourceID resourceIDByRID:<rid>]
 @return A preprocess step
 */
+ (EXORpcPreprocessOperation *)preprocessOperation:(EXORpcPreprocessOperation_t)operation rid:(EXORpcResourceID *)rid;

/**
 Initialize a preprocess step

 @param operation The operation to take
 @param value The constant to use
 @return A preprocess step
 */
- (instancetype)initWithOperation:(EXORpcPreprocessOperation_t)operation value:(NSNumber*)value;

/**
 Initialize a preprocess step

 @param operation The operation to take
 @param rid A resource id to read for the value to use. Must be created with [EXORpcResourceID resourceIDByRID:<rid>]
 @return A preprocess step
 */
- (instancetype)initWithOperation:(EXORpcPreprocessOperation_t)operation rid:(EXORpcResourceID*)rid;

/**
 Initialize a preprocess step with an array from an info description

 @param plist An array element from an infor request
 @return A preprocess step
 */
- (instancetype)initWithPList:(NSArray*)plist;

/**
 Return the resource as a JSON ready plist.
 */
- (NSArray*)plistValue;

@end
