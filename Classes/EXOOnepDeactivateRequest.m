//
//  EXOOnepDeactivateRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepDeactivateRequest.h"

@interface EXOOnepDeactivateRequest ()
@property(nonatomic,assign) BOOL asShare;
@property(nonatomic,copy) NSString *code;
@property(nonatomic,copy) EXOOnepRequestComplete complete;
@end

@implementation EXOOnepDeactivateRequest

+ (EXOOnepDeactivateRequest *)deactivateShare:(BOOL)asShare code:(NSString *)code complete:(EXOOnepRequestComplete)complete
{
    return [[EXOOnepDeactivateRequest alloc] initWithShare:asShare code:code complete:complete];
}

-(id)initWithShare:(BOOL)asShare code:(NSString *)code complete:(EXOOnepRequestComplete)complete
{
    if (self = [super init]) {
        self.asShare = asShare;
        self.code = code;
        self.complete = complete;
    }
    return self;
}

- (void)doResult:(NSDictionary *)result error:(NSError *)error
{
    if (self.complete) {
        NSError *err = [self errorFromStatus:result];
        if (err) {
            self.complete(err);
        } else {
            self.complete(nil);
        }
    }
}

- (NSDictionary*)asCall
{
    return @{@"procedure": @"deactivate", @"arguments": @[(self.asShare?@"share":@"client"), self.code]};
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    EXOOnepDeactivateRequest *obj = object;
    return (self.asShare == obj.asShare &&
            [self.code isEqualToString:obj.code]);
}

- (NSUInteger)hash
{
    return self.asShare ^ self.code.hash;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

@end
