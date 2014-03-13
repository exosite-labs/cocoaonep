//
//  EXORpcDropRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcRequest.h"

@interface EXORpcDropRequest : EXORpcRequest <NSCopying>
@property(nonatomic,copy,readonly) EXORpcRequestComplete complete;

+ (EXORpcDropRequest*) dropWithRID:(EXORpcResourceID *)rid complete:(EXORpcRequestComplete)complete;
- (instancetype)initWithRID:(EXORpcResourceID *)rid complete:(EXORpcRequestComplete)complete;
@end
