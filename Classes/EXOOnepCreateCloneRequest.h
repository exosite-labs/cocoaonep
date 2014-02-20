//
//  EXOOnepCreateCloneRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepCreateRequest.h"

@interface EXOOnepCreateCloneRequest : EXOOnepCreateRequest
@property(strong) NSString *code;
@property(assign) BOOL noaliases;
@property(assign) BOOL nohistorical;

@end
