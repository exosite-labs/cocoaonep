//
//  EXOOnePMapRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcRequest.h"

@interface EXORpcMapRequest : EXORpcRequest
@property(strong) NSString *aliasName;
@property(copy) EXORpcRequestComplete complete;
@end
