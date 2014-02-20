//
//  EXOOnepCreateCloneRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepResource.h"

@interface EXOOnepCloneResource : EXOOnepResource
@property(nonatomic,copy) EXOOnepResourceID *rid;
@property(strong) NSString *code;
@property(assign) BOOL noaliases;
@property(assign) BOOL nohistorical;

@end
