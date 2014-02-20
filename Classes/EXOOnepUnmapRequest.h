//
//  EXOOnepUnmapRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepRequest.h"

@interface EXOOnepUnmapRequest : EXOOnepRequest
@property(strong) NSString *alias;
@property(copy) EXOOnepRequestComplete complete;
@end
