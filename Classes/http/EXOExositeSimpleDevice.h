//
//  EXOExositeSimpleDevice.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^EXOExositeSimpleClientWriteComplete)(NSError*);
typedef void(^EXOExositeSimpleClientReadComplete)(NSDictionary*,NSError*);

@interface EXOExositeSimpleDevice : NSObject <NSCopying>
@property(nonatomic,copy,readonly) NSString *CIK;

- (id)initWithCIK:(NSString*)CIK;
- (void)writeAliases:(NSDictionary*)data complete:(EXOExositeSimpleClientWriteComplete)complete;
- (void)readAliases:(NSArray*)aliases complete:(EXOExositeSimpleClientReadComplete)complete;

@end
