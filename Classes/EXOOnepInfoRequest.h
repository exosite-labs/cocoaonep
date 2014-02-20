//
//  EXOOnepInfoRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepRequest.h"

typedef void(^EXOOnepInfoRequestComplete)(NSDictionary *res, NSError *err);

@interface EXOOnepInfoRequest : EXOOnepRequest
@property(assign) BOOL aliases;
@property(assign) BOOL basic;
@property(assign) BOOL comments;
@property(assign) BOOL counts;
@property(assign) BOOL description;
@property(assign) BOOL key;
@property(assign) BOOL shares;
@property(assign) BOOL tagged;
@property(assign) BOOL tags;
@property(assign) BOOL usage;
@property(copy) EXOOnepInfoRequestComplete complete;
@end
