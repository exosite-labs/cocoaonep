//
//  EXOOnepAuthKey.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EXOOnepAuthKey : NSObject <NSCopying>
// Other Auth mode coming later. (with client_id or resource_id)

+ (EXOOnepAuthKey*)authWithCIK:(NSString*)cik;

- (instancetype)initWithCIK:(NSString*)cik;

- (NSDictionary*)plistValue;
@end
