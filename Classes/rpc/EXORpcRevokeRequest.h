//
//  EXORpcRevokeRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcRequest.h"

@interface EXORpcRevokeRequest : EXORpcRequest <NSCopying>
@property(assign,nonatomic,readonly) BOOL asShare;
@property(strong,nonatomic,readonly) NSString *code;
@property(copy,nonatomic,readonly) EXORpcRequestComplete complete;

+ (EXORpcRevokeRequest*)revokeWithCode:(NSString*)code asShare:(BOOL)asShare complete:(EXORpcRequestComplete)complete;
- (instancetype)initWithCode:(NSString*)code asShare:(BOOL)asShare complete:(EXORpcRequestComplete)complete;

@end
