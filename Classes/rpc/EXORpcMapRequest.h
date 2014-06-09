//
//  EXOOnePMapRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcRequest.h"

/**
 Creates an alias for a resource.
 */
@interface EXORpcMapRequest : EXORpcRequest <NSCopying>
@property(strong,nonatomic,readonly) NSString *aliasName; /// Name to use for alias
@property(copy,nonatomic,readonly) EXORpcRequestComplete complete; /// Callback when complete

/**
 Create a mapping
 
 @param rid The target resource for the alias
 @param alias The name of the alias
 @param complete Callback on complete
 @return THe map request
 */
+ (EXORpcMapRequest*)mapWithRID:(EXORpcResourceID *)rid to:(NSString*)alias complete:(EXORpcRequestComplete)complete;

/**
 Initialize a mapping

 @param rid The target resource for the alias
 @param alias The name of the alias
 @param complete Callback on complete
 @return THe map request
 */
- (instancetype)initWithRID:(EXORpcResourceID *)rid to:(NSString*)alias complete:(EXORpcRequestComplete)complete;
@end
