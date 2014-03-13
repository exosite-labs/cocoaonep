//
//  EXOOnepCreateRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepRequest.h"
#import "EXOOnepResource.h"

typedef void(^EXOOnepCreateRequestComplete)(EXOOnepResourceID *RID, NSError *error);

@interface EXOOnepCreateRequest : EXOOnepRequest <NSCopying>
@property(nonatomic,copy,readonly) EXOOnepResource *resource;
@property(nonatomic,copy,readonly) EXOOnepCreateRequestComplete complete;

+ (EXOOnepCreateRequest*)createWithResource:(EXOOnepResource*)resource complete:(EXOOnepCreateRequestComplete)complete;
- (instancetype)initWithResource:(EXOOnepResource*)resource complete:(EXOOnepCreateRequestComplete)complete;
- (NSDictionary *)plistValue;

@end
