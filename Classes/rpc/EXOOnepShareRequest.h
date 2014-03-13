//
//  EXOOnepShareRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepRequest.h"

typedef void(^EXOOnepShareRequestComplete)(NSString *shareCode, NSError *err);

@interface EXOOnepShareRequest : EXOOnepRequest
@property(strong) NSDate *duration;
@property(strong) NSNumber *count;
@property(copy) EXOOnepShareRequestComplete complete;
@end
