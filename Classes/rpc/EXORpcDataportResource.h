//
//  EXORpcDataportResource.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcResource.h"
#import "EXORpcPreprocessOperation.h"

enum EXORpcDataportFormat_e {
    EXORpcDataportFormatString = 0,
    EXORpcDataportFormatFloat,
    EXORpcDataportFormatInteger,

    EXORpcDataportFormatUnchanged, // For update requests
};
typedef enum EXORpcDataportFormat_e EXORpcDataportFormat_t;

@interface EXORpcDataportResource : EXORpcResource
@property(assign,nonatomic,readonly) EXORpcDataportFormat_t format;
@property(strong,nonatomic,readonly) NSArray *preprocess;
@property(strong,nonatomic,readonly) EXORpcResourceID *subscribe;
@property(copy,nonatomic,readonly) EXORpcResourceRetention *retention;

+ (EXORpcDataportResource*)dataportWithName:(NSString *)name format:(EXORpcDataportFormat_t)format;
+ (EXORpcDataportResource*)dataportWithName:(NSString *)name format:(EXORpcDataportFormat_t)format retention:(EXORpcResourceRetention*)retention;
+ (EXORpcDataportResource*)dataportWithName:(NSString *)name meta:(NSString *)meta format:(EXORpcDataportFormat_t)format preprocess:(NSArray*)preprocess subscribe:(EXORpcResourceID*)subscribe retention:(EXORpcResourceRetention*)retention;

- (instancetype)initWithName:(NSString *)name meta:(NSString *)meta format:(EXORpcDataportFormat_t)format preprocess:(NSArray*)preprocess subscribe:(EXORpcResourceID*)subscribe retention:(EXORpcResourceRetention*)retention;
@end
