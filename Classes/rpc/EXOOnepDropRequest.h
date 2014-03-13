//
//  EXOOnepDropRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepRequest.h"

@interface EXOOnepDropRequest : EXOOnepRequest <NSCopying>
@property(nonatomic,copy,readonly) EXOOnepRequestComplete complete;

+ (EXOOnepDropRequest*) dropWithRID:(EXOOnepResourceID *)rid complete:(EXOOnepRequestComplete)complete;
- (instancetype)initWithRID:(EXOOnepResourceID *)rid complete:(EXOOnepRequestComplete)complete;
@end
