//
//  EXORpcReadRequest.h
//
//  Created by Michael Conrad Tadpol Tilstra.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXORpcRequest.h"

enum EXORpcReadSelectionType {
    EXORpcReadSelectionTypeAll,
    EXORpcReadSelectionTypeGivenWindow,
    EXORpcReadSelectionTypeAutoWindow
};
typedef enum EXORpcReadSelectionType EXORpcReadSelectionType_t;

typedef void(^EXORpcReadRequestComplete)(NSArray* results, NSError *error);

@interface EXORpcReadRequest : EXORpcRequest <NSCopying>
@property(nonatomic,strong,readonly) NSDate *starttime;
@property(nonatomic,strong,readonly) NSDate *endtime;
@property(nonatomic,assign,readonly) BOOL sortAscending;
@property(nonatomic,assign,readonly) NSUInteger limit;
@property(nonatomic,assign,readonly) EXORpcReadSelectionType_t selection;
@property(nonatomic,copy,readonly) EXORpcReadRequestComplete complete;

+ (EXORpcReadRequest*)readWithRID:(EXORpcResourceID*)rid complete:(EXORpcReadRequestComplete)complete;

+ (EXORpcReadRequest*)readWithRID:(EXORpcResourceID*)rid startTime:(NSDate*)starttime endTime:(NSDate*)endtime ascending:(BOOL)ascending limit:(NSUInteger)limit selection:(EXORpcReadSelectionType_t)selection complete:(EXORpcReadRequestComplete)complete;

- (instancetype)initWithRID:(EXORpcResourceID*)rid startTime:(NSDate*)starttime endTime:(NSDate*)endtime ascending:(BOOL)ascending limit:(NSUInteger)limit selection:(EXORpcReadSelectionType_t)selection complete:(EXORpcReadRequestComplete)complete;

@end
