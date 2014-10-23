//
//  EXORpcWaitRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//
//

#import "EXORpcRequest.h"

typedef void(^EXORpcWaitRequestComplete)(NSDictionary* results, NSError *error);

@interface EXORpcWaitRequest : EXORpcRequest <NSCopying>
@property (copy,nonatomic,readonly) NSArray *resourceIDs;
@property (copy,nonatomic,readonly) NSNumber *timeout;
@property (copy,nonatomic,readonly) NSDate *since;
@property (copy,nonatomic,readonly) EXORpcWaitRequestComplete complete;

+ (EXORpcWaitRequest*)waitRequestWithRIDs:(NSArray*)rids complete:(EXORpcWaitRequestComplete)complete;
+ (EXORpcWaitRequest*)waitRequestWithRIDs:(NSArray*)rids timeoutAfter:(NSNumber*)timeout complete:(EXORpcWaitRequestComplete)complete;
+ (EXORpcWaitRequest*)waitRequestWithRIDs:(NSArray*)rids timeoutAfter:(NSNumber*)timeout since:(NSDate*)since complete:(EXORpcWaitRequestComplete)complete;

- (instancetype)initWithRIDs:(NSArray*)rids timeoutAfter:(NSNumber*)timeout since:(NSDate*)since complete:(EXORpcWaitRequestComplete)complete;

@end
