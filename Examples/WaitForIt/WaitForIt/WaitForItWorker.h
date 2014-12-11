//
//  WaitForItWorker.h
//  WaitForIt
//
//  Created by Michael Conrad Tadpol Tilstra on 12/11/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^WaitedForThis)(NSNumber* number, NSError *error);

@interface WaitForItWorker : NSObject
@property (assign,nonatomic,readonly) BOOL isSetup;

- (void)createPortsAndScripts;
- (void)setWaitRate:(NSUInteger)seconds;
- (void)waitForIt:(WaitedForThis)complete;

@end
