//
//  EXORpcDataruleScript.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcDatarule.h"

@interface EXORpcDataruleScript : EXORpcDatarule <NSCopying>
@property(nonatomic,copy,readonly) NSString *script;

+ (EXORpcDataruleScript*)dataruleScriptWithScript:(NSString*)script;
- (instancetype)initWithScript:(NSString*)script;
@end
