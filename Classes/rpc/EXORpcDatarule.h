//
//  EXORpcDatarule.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Comparison tyles used in some data rules.
 */
enum EXORpcDataruleComparison_e {
    EXORpcDataruleComparisonGreaterThan,
    EXORpcDataruleComparisonLessThan,
    EXORpcDataruleComparisonEqual,
    EXORpcDataruleComparisonGreaterOrEqual,
    EXORpcDataruleComparisonLessOrEqual,
    EXORpcDataruleComparisonNotEqual
};
typedef enum EXORpcDataruleComparison_e EXORpcDataruleComparison_t;

/**
 Base Class for Datarules; DOn;t use thie directly.
 */
@interface EXORpcDatarule : NSObject <NSCopying>

/**
 Get the string key of the comparison for JSON encoding.
 */
- (NSString*)stringFromComparison:(EXORpcDataruleComparison_t)comp;

/**
 Return this data rule as a plist that can be converted into JSON.

 @return JSON ready dictionary of values.
 */
- (NSDictionary*)plistValue;
@end
