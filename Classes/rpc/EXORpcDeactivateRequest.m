//
//  EXORpcDeactivateRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcDeactivateRequest.h"

@interface EXORpcDeactivateRequest ()
@property(nonatomic,assign) BOOL asShare;
@property(nonatomic,copy) NSString *code;
@property(nonatomic,copy) EXORpcRequestComplete complete;
@end

@implementation EXORpcDeactivateRequest

+ (EXORpcDeactivateRequest *)deactivateClientWithCode:(NSString *)code complete:(EXORpcRequestComplete)complete
{
    return [[EXORpcDeactivateRequest alloc] initWithShare:NO code:code complete:complete];
}

+ (EXORpcDeactivateRequest *)deactivateShareWithCode:(NSString *)code complete:(EXORpcRequestComplete)complete
{
    return [[EXORpcDeactivateRequest alloc] initWithShare:YES code:code complete:complete];
}

-(id)initWithShare:(BOOL)asShare code:(NSString *)code complete:(EXORpcRequestComplete)complete
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

- (NSDictionary*)plistValue
{
    return @{@"procedure": @"deactivate", @"arguments": @[(self.asShare?@"share":@"client"), self.code]};
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    EXORpcDeactivateRequest *obj = object;
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
