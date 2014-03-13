//
//  EXORpcCreateRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcRequest.h"
#import "EXORpcResource.h"

typedef void(^EXORpcCreateRequestComplete)(EXORpcResourceID *RID, NSError *error);

@interface EXORpcCreateRequest : EXORpcRequest <NSCopying>
@property(nonatomic,copy,readonly) EXORpcResource *resource;
@property(nonatomic,copy,readonly) EXORpcCreateRequestComplete complete;

+ (EXORpcCreateRequest*)createWithResource:(EXORpcResource*)resource complete:(EXORpcCreateRequestComplete)complete;
- (instancetype)initWithResource:(EXORpcResource*)resource complete:(EXORpcCreateRequestComplete)complete;
- (NSDictionary *)plistValue;

@end
