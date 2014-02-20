//
//  EXOOnePMapRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepRequest.h"

@interface EXOOnepMapRequest : EXOOnepRequest
@property(strong) NSString *aliasName;
@property(copy) EXOOnepRequestComplete complete;
@end
