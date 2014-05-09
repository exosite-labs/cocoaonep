//
//  EXORpcRecordRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcRequest.h"
#import "EXORpcValue.h"

@interface EXORpcRecordRequest : EXORpcRequest <NSCopying>
@property(strong,nonatomic,readonly) NSArray *values;  // Array of EXORpcValues
@property(copy,nonatomic,readonly) EXORpcRequestComplete complete;

+ (EXORpcRecordRequest*)recordWithRID:(EXORpcResourceID *)rid values:(NSArray*)values complete:(EXORpcRequestComplete)complete;

- (instancetype)initWithRID:(EXORpcResourceID *)rid values:(NSArray*)values complete:(EXORpcRequestComplete)complete;

@end
