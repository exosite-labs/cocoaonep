//
//  EXOOnepCreateRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepRequest.h"
#import "EXOOnepResource.h"

typedef void(^EXOOnepCreateRequestComplete)(EXOOnepResourceID *RID, NSError *error);

@interface EXOOnepCreateRequest : EXOOnepRequest
@property(nonatomic,copy) EXOOnepResource *resource;
@property(nonatomic,copy) EXOOnepCreateRequestComplete complete;
@end
