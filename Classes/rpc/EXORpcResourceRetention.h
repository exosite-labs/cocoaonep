//
//  EXORpcResourceRetention.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EXORpcResourceRetention : NSObject <NSCopying>
@property(copy,nonatomic,readonly) NSNumber *count;
@property(copy,nonatomic,readonly) NSNumber *duration;

+ (EXORpcResourceRetention*)retentionWithCount:(NSNumber*)count duration:(NSNumber*)duration;
- (instancetype)initWithCount:(NSNumber*)count duration:(NSNumber*)duration;

- (id)plistValue;
@end
