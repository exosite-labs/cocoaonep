//
//  EXOOnepDataruleScript.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepDatarule.h"

@interface EXOOnepDataruleScript : EXOOnepDatarule <NSCopying>
@property(nonatomic,copy,readonly) NSString *script;

+ (EXOOnepDataruleScript*)dataruleScriptWithScript:(NSString*)script;
- (instancetype)initWithScript:(NSString*)script;
@end
