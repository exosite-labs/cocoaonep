//
//  EXORpcCreateDispatchRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcResource.h"

enum EXORpcDispactMethod_e {
    EXORpcDispactMethodEmail,
    EXORpcDispactMethodHttpGet,
    EXORpcDispactMethodHttpPost,
    EXORpcDispactMethodHttpPut,
    EXORpcDispactMethodSms,
    EXORpcDispactMethodXmpp,
};
typedef enum EXORpcDispactMethod_e EXORpcDispactMethod_t;

@interface EXORpcDispatchResource : EXORpcResource
@property(assign) BOOL locked;
@property(copy) NSString *message;
@property(assign) EXORpcDispactMethod_t method;
@property(strong) NSArray *preprocess;
@property(copy) NSString *recipient;
@property(copy) NSNumber *retentionCount;
@property(copy) NSNumber *retentionDuration;
@property(copy) NSString *subject;
@property(strong) EXORpcResourceID *subscribe;

@end
