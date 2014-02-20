//
//  EXOOnepCreateRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepRequest.h"
#import "EXOOnepResourceID.h"

typedef void(^EXOOnepCreateRequestComplete)(EXOOnepResourceID *RID, NSError *error);

@interface EXOOnepCreateRequest : EXOOnepRequest
@property(copy) NSString *meta;
@property(copy) NSString *name;
@property(assign) BOOL public;

@property(copy) EXOOnepCreateRequestComplete complete;
@end
