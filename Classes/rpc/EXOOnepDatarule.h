//
//  EXORpcDatarule.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <Foundation/Foundation.h>

enum EXORpcDataruleComparison_e {
    EXORpcDataruleComparisonGreaterThan,
    EXORpcDataruleComparisonLessThan,
    EXORpcDataruleComparisonEqual,
    EXORpcDataruleComparisonGreaterOrEqual,
    EXORpcDataruleComparisonLessOrEqual,
    EXORpcDataruleComparisonNotEqual
};
typedef enum EXORpcDataruleComparison_e EXORpcDataruleComparison_t;

@interface EXORpcDatarule : NSObject <NSCopying>
- (NSString*)stringFromComparison:(EXORpcDataruleComparison_t)comp;
- (NSDictionary*)plistValue;
@end
