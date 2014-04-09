//
//  EXORpcUpdateRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcRequest.h"
#import "EXORpcResource.h"

@interface EXORpcUpdateRequest : EXORpcRequest
@property(nonatomic,copy,readonly) EXORpcResource *resource;
@property(nonatomic,copy,readonly) EXORpcRequestComplete complete;

+ (EXORpcUpdateRequest*)updateWithRID:(EXORpcResourceID*)rid resource:(EXORpcResource*)resource complete:(EXORpcRequestComplete)complete;
- (instancetype)initWithRID:(EXORpcResourceID*)rid resource:(EXORpcResource*)resource complete:(EXORpcRequestComplete)complete;
- (NSDictionary *)plistValue;

@end
