//
//  EXOHttpClient.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^EXOHttpClientWriteComplete)(NSError*);
typedef void(^EXOHttpClientReadComplete)(NSDictionary*,NSError*);

@interface EXOHttpClient : NSObject <NSCopying>
@property(nonatomic,copy,readonly) NSString *CIK;
@property(nonatomic,copy,readonly) NSURL *host;

- (instancetype)initWithCIK:(NSString*)CIK;
- (instancetype)initWithCIK:(NSString*)CIK host:(NSURL*)host;
- (void)writeAliases:(NSDictionary*)data complete:(EXOHttpClientWriteComplete)complete;
- (void)readAliases:(NSArray*)aliases complete:(EXOHttpClientReadComplete)complete;

@end
