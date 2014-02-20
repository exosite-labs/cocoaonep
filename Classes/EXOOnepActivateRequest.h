//
//  EXOOnepActivateRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepRequest.h"

@interface EXOOnepActivateRequest : EXOOnepRequest
@property(assign) BOOL asShare;
@property(copy) NSString *code;
@property(copy) EXOOnepRequestComplete complete;
@end
