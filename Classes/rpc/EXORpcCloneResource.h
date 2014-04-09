//
//  EXORpcCreateCloneRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcResource.h"

@interface EXORpcCloneResource : EXORpcResource
@property(copy,nonatomic,readonly) EXORpcResourceID *rid;
@property(copy,nonatomic,readonly) NSString *code;
@property(assign,nonatomic,readonly) BOOL noaliases;
@property(assign,nonatomic,readonly) BOOL nohistorical;

+ (EXORpcCloneResource*)resrouceWithName:(NSString *)name meta:(NSString *)meta public:(BOOL)public rid:(EXORpcResourceID*)rid code:(NSString*)code noaliases:(BOOL)noaliases nohistorical:(BOOL)nohistorical;
+ (EXORpcCloneResource*)resrouceWithName:(NSString *)name meta:(NSString *)meta rid:(EXORpcResourceID*)rid code:(NSString*)code;

- (instancetype)initWithName:(NSString *)name meta:(NSString *)meta public:(BOOL)public rid:(EXORpcResourceID*)rid code:(NSString*)code noaliases:(BOOL)noaliases nohistorical:(BOOL)nohistorical;

@end
