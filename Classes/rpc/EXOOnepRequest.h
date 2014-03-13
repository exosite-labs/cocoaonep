//
//  EXORpcRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EXORpcResourceID.h"

extern NSString *kEXORpcErrorDomain;

#define kEXORpcErrorTypeUnknown    -1
#define kEXORpcErrorTypeOk         0
#define kEXORpcErrorTypeInvalid    1
#define kEXORpcErrorTypeNoAuth     2


typedef void(^EXORpcRequestComplete)(NSError *err);

@interface EXORpcRequest : NSObject
@property(nonatomic,copy) EXORpcResourceID *rid;

- (instancetype)initWithRID:(EXORpcResourceID*)rid;
- (id)init;

- (NSInteger)codeFromStatus:(NSString*)status;
- (NSError*)errorFromStatus:(NSDictionary*)status;
- (void)doResult:(NSDictionary*)result error:(NSError*)error;
- (NSDictionary*)plistValue;

@end
