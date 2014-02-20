//
//  EXOOnepRevokeRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepRequest.h"

@interface EXOOnepRevokeRequest : EXOOnepRequest
@property(assign) BOOL asShare;
@property(strong) NSString *code;
@property(copy) EXOOnepRequestComplete complete;
@end
