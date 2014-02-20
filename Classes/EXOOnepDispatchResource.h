//
//  EXOOnepCreateDispatchRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepResource.h"

enum EXOOnepDispactMethod_e {
    EXOOnepDispactMethodEmail,
    EXOOnepDispactMethodHttpGet,
    EXOOnepDispactMethodHttpPost,
    EXOOnepDispactMethodHttpPut,
    EXOOnepDispactMethodSms,
    EXOOnepDispactMethodXmpp,
};
typedef enum EXOOnepDispactMethod_e EXOOnepDispactMethod_t;

@interface EXOOnepDispatchResource : EXOOnepResource
@property(assign) BOOL locked;
@property(copy) NSString *message;
@property(assign) EXOOnepDispactMethod_t method;
@property(strong) NSArray *preprocess;
@property(copy) NSString *recipient;
@property(copy) NSNumber *retentionCount;
@property(copy) NSNumber *retentionDuration;
@property(copy) NSString *subject;
@property(strong) EXOOnepResourceID *subscribe;

@end
