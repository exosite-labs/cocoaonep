//
//  EXOCPValuesForDataports.m
//
//  Created by Michael Conrad Tadpol Tilstra on 4/15/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOCPValuesForDataports.h"

NSString *kEXOCPValuesForDataportsAuthKey = @"kEXOCPValuesForDataportsAuthKey";
NSString *kEXOCPValuesForDataportsRIDKey = @"kEXOCPValuesForDataportsRIDKey";
NSString *kEXOCPValuesForDataportsErrorKey = @"kEXOCPValuesForDataportsErrorKey";
NSString *kEXOCPValuesForDataportsResultKey = @"kEXOCPValuesForDataportsResultKey";

@interface EXOCPValuesForDataports ()
@property (strong,nonatomic) NSMutableArray *collect;
@end

@implementation EXOCPValuesForDataports {
    BOOL        executing;
    BOOL        finished;
    dispatch_queue_t _collectionQ;
}

- (id)init
{
    if ([super init]) {
        _collectionQ = dispatch_queue_create("com.exosite.EXOCPValuesForDataports", DISPATCH_QUEUE_SERIAL);
        _collect = [NSMutableArray new];
    }
    return self;
}

- (BOOL)isConcurrent {
    return YES;
}

- (BOOL)isExecuting {
    return executing;
}

- (BOOL)isFinished {
    return finished;
}

- (void)start {
    // Always check for cancellation before launching the task.
    if ([self isCancelled])
    {
        // Must move the operation to the finished state if it is canceled.
        [self willChangeValueForKey:@"isFinished"];
        finished = YES;
        [self didChangeValueForKey:@"isFinished"];
        return;
    }

    // If the operation is not canceled, begin executing the task.
    [self willChangeValueForKey:@"isExecuting"];
    executing = YES;
    [self getThoseValues];
    [self didChangeValueForKey:@"isExecuting"];
}

- (void)completeOperation {
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];

    executing = NO;
    finished = YES;

    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

- (void)getThoseValues
{
    if (self.readTemplate == nil) {
        self.readTemplate = [EXORpcReadRequest readWithRID:nil complete:nil];
    }

    NSMutableDictionary *grouped = [NSMutableDictionary new];
    for (NSArray *item in self.dataports) {
        EXORpcAuthKey *auth = item[0];
        EXORpcResourceID *rid = item[1];
        // TODO vailidate object types.
        if (grouped[auth] == nil) {
            grouped[auth] = [NSMutableArray new];
        }
        [(NSMutableArray*)(grouped[auth]) addObject:rid];
    }

    NSMutableArray *ops = [NSMutableArray new];
    NSOperation *final = [NSBlockOperation blockOperationWithBlock:^{
        dispatch_async(_collectionQ, ^{
            if (self.complete) {
                self.complete([self.collect copy]);
            }
            [self completeOperation];
        });
    }];
    [ops addObject:final];

    for (EXORpcAuthKey *key in grouped) {
        NSMutableArray *calls = [NSMutableArray new];
        for (EXORpcResourceID *rid in grouped[key]) {
            EXORpcReadRequest *rr = [EXORpcReadRequest readWithRID:rid
                                                          startTime:self.readTemplate.starttime
                                                            endTime:self.readTemplate.endtime
                                                          ascending:self.readTemplate.sortAscending
                                                              limit:self.readTemplate.limit
                                                          selection:self.readTemplate.selection
                                                           complete:^(NSArray *results, NSError *error) {
                if (error) {
                    dispatch_async(_collectionQ, ^{
                        [self.collect addObject:@{kEXOCPValuesForDataportsAuthKey: key, kEXOCPValuesForDataportsRIDKey: rid, kEXOCPValuesForDataportsErrorKey: error}];
                    });
                } else {
                    NSArray *item = results[0];
                    dispatch_async(_collectionQ, ^{
                        [self.collect addObject:@{kEXOCPValuesForDataportsAuthKey: key, kEXOCPValuesForDataportsRIDKey: rid, kEXOCPValuesForDataportsResultKey: item}];
                    });
                }
            }];
            [calls addObject:rr];
        }
        NSBlockOperation *blocker = [NSBlockOperation blockOperationWithBlock:^{}];
        [final addDependency:blocker];
        NSOperation *op = [self.onep operationWithAuth:key requests:calls complete:^(NSError *error) {
            dispatch_async(_collectionQ, ^{
                if (error) {
                    for (EXORpcResourceID *rid in grouped[key]) {
                        [self.collect addObject:@{kEXOCPValuesForDataportsAuthKey: key, kEXOCPValuesForDataportsRIDKey: rid, kEXOCPValuesForDataportsErrorKey: error}];
                    }
                }
                [self.onep.queue addOperation:blocker]; // Adding here forces final to wait until we're done.
            });

        }];
        [ops addObject:op];
        [final addDependency:op];
    }

    [self.onep.queue addOperations:ops waitUntilFinished:NO];
}

@end
