//
//  EXORpcRevokeRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcRequest.h"

@interface EXORpcRevokeRequest : EXORpcRequest
@property(assign) BOOL asShare;
@property(strong) NSString *code;
@property(copy) EXORpcRequestComplete complete;
@end
