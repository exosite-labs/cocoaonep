//
//  EXORpcCreateCloneRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcResource.h"

@interface EXORpcCloneResource : EXORpcResource
@property(nonatomic,copy) EXORpcResourceID *rid;
@property(strong) NSString *code;
@property(assign) BOOL noaliases;
@property(assign) BOOL nohistorical;

@end
