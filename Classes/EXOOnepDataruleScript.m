//
//  EXOOnepDataruleScript.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepDataruleScript.h"

@interface EXOOnepDataruleScript ()
@property(nonatomic,copy) NSString *script;
@end

@implementation EXOOnepDataruleScript

+ (EXOOnepDataruleScript *)dataruleScriptWithScript:(NSString *)script
{
    return [[EXOOnepDataruleScript alloc] initWithScript:script];
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


- (NSDictionary *)asCall
{
    return @{@"script": self.script};
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    EXOOnepDataruleScript *obj = object;
    return [self.script isEqualToString:obj.script];
}

- (NSUInteger)hash
{
    return self.script.hash;
}

@end
