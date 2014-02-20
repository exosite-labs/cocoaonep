//
//  EXOOnepReadRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOOnepRequest.h"

enum EXOOnepReadSelectionType {
    EXOOnepReadSelectionTypeAll,
    EXOOnepReadSelectionTypeGivenWindow,
    EXOOnepReadSelectionTypeAutoWindow
};
typedef enum EXOOnepReadSelectionType EXOOnepReadSelectionType_t;

typedef void(^EXOOnepReadRequestComplete)(NSArray* results, NSError *error);

@interface EXOOnepReadRequest : EXOOnepRequest
@property(strong) NSDate *starttime;
@property(strong) NSDate *endtime;
@property(assign) BOOL sortAscending;
@property(assign) NSUInteger limit;
@property(assign) EXOOnepReadSelectionType_t selection;
@property(copy) EXOOnepReadRequestComplete complete;
@end
