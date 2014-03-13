//
//  EXORpcDataruleScript.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcDataruleScript.h"

@interface EXORpcDataruleScript ()
@property(nonatomic,copy) NSString *script;
@end

@implementation EXORpcDataruleScript

+ (EXORpcDataruleScript *)dataruleScriptWithScript:(NSString *)script
{
    return [[EXORpcDataruleScript alloc] initWithScript:script];
}

- (id)initWithScript:(NSString *)script
{
    if (self = [super init]) {
        self.script = script;
    }
    return self;
}

- (id)init
{
    return nil;
}


- (NSDictionary *)plistValue
{
    return @{@"script": self.script};
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    EXORpcDataruleScript *obj = object;
    return [self.script isEqualToString:obj.script];
}

- (NSUInteger)hash
{
    return self.script.hash;
}

@end
