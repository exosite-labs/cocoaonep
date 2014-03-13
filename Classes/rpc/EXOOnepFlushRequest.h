//
//  EXORpcFlushRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcRequest.h"

@interface EXORpcFlushRequest : EXORpcRequest <NSCopying>
@property(nonatomic,copy,readonly) NSDate *newerthan;
@property(nonatomic,copy,readonly) NSDate *olderthan;
@property(nonatomic,copy,readonly) EXORpcRequestComplete complete;

+ (EXORpcFlushRequest*)flushRID:(EXORpcResourceID *)rid newerThan:(NSDate*)newerthan olderThan:(NSDate*)olderthan complete:(EXORpcRequestComplete)complete;
- (instancetype)initWithRID:(EXORpcResourceID *)rid newerThan:(NSDate*)newerthan olderThan:(NSDate*)olderthan complete:(EXORpcRequestComplete)complete;

@end
