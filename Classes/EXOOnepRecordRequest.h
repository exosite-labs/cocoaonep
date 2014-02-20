//
//  EXOOnepRecordRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepRequest.h"

@interface EXOOnepRecordRequest : EXOOnepRequest
@property(strong) NSArray *values;
@property(copy) EXOOnepRequestComplete complete;
@end
