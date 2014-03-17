//
//  EXORpcWriteRequest.m
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcWriteRequest.h"

@interface EXORpcWriteRequest ()
@property(nonatomic,copy) NSString *value;
@property(nonatomic,copy) EXORpcRequestComplete complete;
@end

@implementation EXORpcWriteRequest

+ (EXORpcWriteRequest *)writeWithRID:(EXORpcResourceID *)rid string:(NSString *)value complete:(EXORpcRequestComplete)complete
{
    return [[EXORpcWriteRequest alloc] initWithRID:rid value:value complete:complete];
}

+ (EXORpcWriteRequest *)writeWithRID:(EXORpcResourceID *)rid number:(NSNumber *)value complete:(EXORpcRequestComplete)complete
{
    return [[EXORpcWriteRequest alloc] initWithRID:rid value:[value stringValue] complete:complete];
}

+ (EXORpcWriteRequest*)writeWithRID:(EXORpcResourceID *)rid plist:(id)value complete:(EXORpcRequestComplete)complete
{
    NSError *err=nil;
    NSData *json = [NSJSONSerialization dataWithJSONObject:value options:0 error:&err];
    if (!json) {
        if (complete) {
            complete(err);
        }
        return nil;
    }
    NSString *sval = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
    return [[EXORpcWriteRequest alloc] initWithRID:rid value:sval complete:complete];
}

- (instancetype)initWithRID:(EXORpcResourceID *)rid value:(NSString*)value complete:(EXORpcRequestComplete)complete
{
    if (self = [super init]) {
        self.rid = rid;
        self.value = value;
        self.complete = complete;
    }
    return self;
}

- (id)init
{
    return nil;
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

- (NSDictionary *)plistValue
{
    return @{@"procedure": @"write", @"arguments": @[[self.rid plistValue], self.value]};
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

@end