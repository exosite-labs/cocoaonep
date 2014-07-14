//
//  EXORpcDataruleScript.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcDatarule.h"

/**
 Reasource for uploading a script.
 */
@interface EXORpcDataruleScript : EXORpcDatarule <NSCopying>

/**
 A string containing Lua source code to run on the server.
 */
@property(nonatomic,copy,readonly) NSString *script;

/**
 Create a script datarule
 
 @param script A string containing Lua source code to run on the server
 @return datarule
 */
+ (EXORpcDataruleScript*)dataruleScriptWithScript:(NSString*)script;

/**
 Initialize a script datarule

 @param script A string containing Lua source code to run on the server
 @return datarule
 */
- (instancetype)initWithScript:(NSString*)script;
@end
