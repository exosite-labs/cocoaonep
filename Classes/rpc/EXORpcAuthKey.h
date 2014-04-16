//
//  EXORpcAuthKey.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EXORpcAuthKey : NSObject <NSCopying>
@property(copy,nonatomic,readonly) NSString *cik;
@property(copy,nonatomic,readonly) NSString *clientid;
@property(copy,nonatomic,readonly) NSString *rid;

+ (EXORpcAuthKey*)authWithCIK:(NSString*)cik;
+ (EXORpcAuthKey*)authWithCIK:(NSString*)cik client:(NSString*)clientid;
+ (EXORpcAuthKey*)authWithCIK:(NSString*)cik resource:(NSString*)rid;

- (instancetype)initWithCIK:(NSString*)cik;

- (NSDictionary*)plistValue;
@end
