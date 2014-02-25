//
//  EXOOnepAuthKey.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EXOOnepAuthKey : NSObject <NSCopying>

+ (EXOOnepAuthKey*)authWithCIK:(NSString*)cik;
+ (EXOOnepAuthKey*)authWithCIK:(NSString*)cik client:(NSString*)clientid;
+ (EXOOnepAuthKey*)authWithCIK:(NSString*)cik resource:(NSString*)rid;

- (instancetype)initWithCIK:(NSString*)cik;

- (NSDictionary*)plistValue;
@end
