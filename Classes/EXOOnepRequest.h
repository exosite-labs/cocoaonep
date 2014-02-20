//
//  EXOOnepRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EXOOnepResourceID.h"

extern NSString *kEXOOnepErrorDomain;

#define kEXOOnepErrorTypeUnknown    -1
#define kEXOOnepErrorTypeOk         0
#define kEXOOnepErrorTypeInvalid    1
#define kEXOOnepErrorTypeNoAuth     2


typedef void(^EXOOnepRequestComplete)(NSError *err);

@interface EXOOnepRequest : NSObject
@property(nonatomic,copy) EXOOnepResourceID *rid;

- (instancetype)initWithRID:(EXOOnepResourceID*)rid;
- (id)init;

- (NSInteger)codeFromStatus:(NSString*)status;
- (NSError*)errorFromStatus:(NSDictionary*)status;
- (void)doResult:(NSDictionary*)result error:(NSError*)error;
- (NSDictionary*)plistValue;

@end
