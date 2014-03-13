//
//  EXORpcAuthKey.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EXORpcAuthKey : NSObject <NSCopying>

+ (EXORpcAuthKey*)authWithCIK:(NSString*)cik;
+ (EXORpcAuthKey*)authWithCIK:(NSString*)cik client:(NSString*)clientid;
+ (EXORpcAuthKey*)authWithCIK:(NSString*)cik resource:(NSString*)rid;

- (instancetype)initWithCIK:(NSString*)cik;

- (NSDictionary*)plistValue;
@end
