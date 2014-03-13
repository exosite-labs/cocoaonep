//
//  EXORpcShareRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcRequest.h"

typedef void(^EXORpcShareRequestComplete)(NSString *shareCode, NSError *err);

@interface EXORpcShareRequest : EXORpcRequest
@property(strong) NSDate *duration;
@property(strong) NSNumber *count;
@property(copy) EXORpcShareRequestComplete complete;
@end
