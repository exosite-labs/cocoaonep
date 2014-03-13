//
//  EXOOnepFlushRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepRequest.h"

@interface EXOOnepFlushRequest : EXOOnepRequest <NSCopying>
@property(nonatomic,copy,readonly) NSDate *newerthan;
@property(nonatomic,copy,readonly) NSDate *olderthan;
@property(nonatomic,copy,readonly) EXOOnepRequestComplete complete;

+ (EXOOnepFlushRequest*)flushRID:(EXOOnepResourceID *)rid newerThan:(NSDate*)newerthan olderThan:(NSDate*)olderthan complete:(EXOOnepRequestComplete)complete;
- (instancetype)initWithRID:(EXOOnepResourceID *)rid newerThan:(NSDate*)newerthan olderThan:(NSDate*)olderthan complete:(EXOOnepRequestComplete)complete;

@end
