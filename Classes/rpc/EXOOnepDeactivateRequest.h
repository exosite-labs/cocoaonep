//
//  EXORpcDeactivateRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcRequest.h"

@interface EXORpcDeactivateRequest : EXORpcRequest <NSCopying>
@property(nonatomic,assign,readonly) BOOL asShare;
@property(nonatomic,copy,readonly) NSString *code;
@property(nonatomic,copy,readonly) EXORpcRequestComplete complete;

+ (EXORpcDeactivateRequest*)deactivateShare:(BOOL)asShare code:(NSString*)code complete:(EXORpcRequestComplete)complete;
- (instancetype)initWithShare:(BOOL)asShare code:(NSString*)code complete:(EXORpcRequestComplete)complete;

@end
