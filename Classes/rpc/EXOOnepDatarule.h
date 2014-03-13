//
//  EXOOnepDatarule.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <Foundation/Foundation.h>

enum EXOOnepDataruleComparison_e {
    EXOOnepDataruleComparisonGreaterThan,
    EXOOnepDataruleComparisonLessThan,
    EXOOnepDataruleComparisonEqual,
    EXOOnepDataruleComparisonGreaterOrEqual,
    EXOOnepDataruleComparisonLessOrEqual,
    EXOOnepDataruleComparisonNotEqual
};
typedef enum EXOOnepDataruleComparison_e EXOOnepDataruleComparison_t;

@interface EXOOnepDatarule : NSObject <NSCopying>
- (NSString*)stringFromComparison:(EXOOnepDataruleComparison_t)comp;
- (NSDictionary*)plistValue;
@end
