//
//  EXOWebSocketSubscribeRequest.m
//  Pods
//
//  Created by Michael Conrad Tadpol Tilstra on 11/4/15.
//
//

#import "EXOWebSocketSubscribeRequest.h"

@interface EXOWebSocketSubscribeRequest ()
@property(copy,nonatomic) EXOWebSocketSubscribedValue update;
@end

@implementation EXOWebSocketSubscribeRequest

+ (EXOWebSocketSubscribeRequest *)subscribeWithRID:(EXORpcResourceID *)rid update:(EXOWebSocketSubscribedValue)update {
    return [[EXOWebSocketSubscribeRequest alloc] initWithRID:rid update:update];
}

- (instancetype)initWithRID:(EXORpcResourceID *)rid update:(EXOWebSocketSubscribedValue)update {
    if (self = [super init]) {
        self.rid = rid;
        self.update = update;
    }
    return self;
}

- (void)doResult:(NSDictionary *)result {

    // {"id":1,"status":"ok","result":[1446667040,10]}
    if (self.update) {
        NSError *err = [self errorFromStatus:result];
        if (err) {
            // self.update(nil, err);
        } else {
            NSArray *item = result[@"result"];
                // item[0] is timestamp
                // item[1] is value
                NSDate *when = [NSDate dateWithTimeIntervalSince1970:[item[0] longLongValue]];

                EXORpcValue *rval;
                id value = item[1];
                if ([value isKindOfClass:[NSString class]]) {
                    rval = [EXORpcValue valueWithDate:when string:value];
                } else if ([value isKindOfClass:[NSNumber class]]) {
                    rval = [EXORpcValue valueWithDate:when number:value];
                } else {
                    rval = [EXORpcValue valueWithDate:when string:[value description]];
                }
            self.update(rval);
        }
    }
}

- (NSDictionary *)plistValue
{
    return @{@"procedure": @"subscribe", @"arguments": @[[self.rid plistValue], @{}]};
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

@end
