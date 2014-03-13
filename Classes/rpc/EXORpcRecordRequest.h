//
//  EXORpcRecordRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcRequest.h"

@interface EXORpcRecordRequest : EXORpcRequest
@property(strong) NSArray *values;
@property(copy) EXORpcRequestComplete complete;
@end
