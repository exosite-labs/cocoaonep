//
//  EXORpcCreateDataportRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcResource.h"

enum EXORpcDataportFormat_e {
    EXORpcDataportFormatString = 0,
    EXORpcDataportFormatFloat,
    EXORpcDataportFormatInteger,
};
typedef enum EXORpcDataportFormat_e EXORpcDataportFormat_t;

@interface EXORpcDataportResource : EXORpcResource
@property(assign) EXORpcDataportFormat_t format;
@property(strong) NSArray *preprocess;
@property(strong) EXORpcResourceID *subscribe;
@property(copy) NSNumber *retentionCount;
@property(copy) NSNumber *retentionDuration;

@end
