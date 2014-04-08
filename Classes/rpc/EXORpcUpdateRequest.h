//
//  EXORpcUpdateRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcRequest.h"
#import "EXORpcResource.h"

typedef void(^EXORpcUpdateRequestComplete)(EXORpcResourceID *RID, NSError *error);

@interface EXORpcUpdateRequest : EXORpcRequest
@property(nonatomic,copy,readonly) EXORpcResource *resource;
@property(nonatomic,copy,readonly) EXORpcUpdateRequestComplete complete;

+ (EXORpcUpdateRequest*)updateWithRID:(EXORpcResourceID*)rid resource:(EXORpcResource*)resource complete:(EXORpcUpdateRequestComplete)complete;
- (instancetype)initWithRID:(EXORpcResourceID*)rid resource:(EXORpcResource*)resource complete:(EXORpcUpdateRequestComplete)complete;
- (NSDictionary *)plistValue;

@end
