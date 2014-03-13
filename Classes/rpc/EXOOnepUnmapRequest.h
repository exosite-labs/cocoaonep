//
//  EXORpcUnmapRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcRequest.h"

@interface EXORpcUnmapRequest : EXORpcRequest
@property(strong) NSString *alias;
@property(copy) EXORpcRequestComplete complete;
@end
