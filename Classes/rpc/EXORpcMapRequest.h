//
//  EXOOnePMapRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcRequest.h"

@interface EXORpcMapRequest : EXORpcRequest <NSCopying>
@property(strong,nonatomic,readonly) NSString *aliasName;
@property(copy,nonatomic,readonly) EXORpcRequestComplete complete;

+ (EXORpcMapRequest*)mapWithRID:(EXORpcResourceID *)rid to:(NSString*)alias complete:(EXORpcRequestComplete)complete;
- (instancetype)initWithRID:(EXORpcResourceID *)rid to:(NSString*)alias complete:(EXORpcRequestComplete)complete;
@end
