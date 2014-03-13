//
//  EXORpcActivateRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcRequest.h"

@interface EXORpcActivateRequest : EXORpcRequest
@property(assign) BOOL asShare;
@property(copy) NSString *code;
@property(copy) EXORpcRequestComplete complete;
@end
