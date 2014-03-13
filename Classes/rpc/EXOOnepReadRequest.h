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

@interface EXOOnepReadRequest : EXOOnepRequest <NSCopying>
@property(nonatomic,strong,readonly) NSDate *starttime;
@property(nonatomic,strong,readonly) NSDate *endtime;
@property(nonatomic,assign,readonly) BOOL sortAscending;
@property(nonatomic,assign,readonly) NSUInteger limit;
@property(nonatomic,assign,readonly) EXOOnepReadSelectionType_t selection;
@property(nonatomic,copy,readonly) EXOOnepReadRequestComplete complete;

+ (EXOOnepReadRequest*)readWithRID:(EXOOnepResourceID*)rid complete:(EXOOnepReadRequestComplete)complete;

+ (EXOOnepReadRequest*)readWithRID:(EXOOnepResourceID*)rid startTime:(NSDate*)starttime endTime:(NSDate*)endtime ascending:(BOOL)ascending limit:(NSUInteger)limit selection:(EXOOnepReadSelectionType_t)selection complete:(EXOOnepReadRequestComplete)complete;

- (instancetype)initWithRID:(EXOOnepResourceID*)rid startTime:(NSDate*)starttime endTime:(NSDate*)endtime ascending:(BOOL)ascending limit:(NSUInteger)limit selection:(EXOOnepReadSelectionType_t)selection complete:(EXOOnepReadRequestComplete)complete;

@end
