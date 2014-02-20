//
//  EXOOnepDeactivateRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepRequest.h"

@interface EXOOnepDeactivateRequest : EXOOnepRequest <NSCopying>
@property(nonatomic,assign,readonly) BOOL asShare;
@property(nonatomic,copy,readonly) NSString *code;
@property(nonatomic,copy,readonly) EXOOnepRequestComplete complete;

+ (EXOOnepDeactivateRequest*)deactivateShare:(BOOL)asShare code:(NSString*)code complete:(EXOOnepRequestComplete)complete;
- (instancetype)initWithShare:(BOOL)asShare code:(NSString*)code complete:(EXOOnepRequestComplete)complete;

@end
