//
//  WaitForItWorker.m
//  WaitForIt
//
//  Created by Michael Conrad Tadpol Tilstra on 12/11/14.
//  Copyright (c) 2013-2014 Exosite. All rights reserved.
//

#import "WaitForItWorker.h"
#import <AFNetworking.h>
#import <EXORpc.h>

@interface WaitForItWorker ()
@property (strong,nonatomic) NSString *CIK;
@property (strong,nonatomic) EXORpc *onep;
@end

#define LoggerNetwork(x, fmt, args...) NSLog(fmt, ##args)

@implementation WaitForItWorker

- (BOOL)isSetup
{
    return self.CIK != nil;
}

- (void)drinkFromCikFountian
{
    NSURL *url = [NSURL URLWithString:@"http://cik.herokuapp.com/"];
    NSError *error = nil;
    self.CIK = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    LoggerNetwork(2, @"temporary CIK: %@", self.CIK);
}

- (EXORpcRequest*)makeSureAliasExists:(NSString*)alias name:(NSString*)name
{
    EXORpcAuthKey * auth = [EXORpcAuthKey authWithCIK:self.CIK];

    EXORpcLookupRequest *lkp = [EXORpcLookupRequest lookupWithType:EXORpcLookupTypeAlias item:alias complete:^(NSString* found, NSError *err){
        if (err) {
            /* Not there, so create, then map */
            EXORpcDataportResource *res = [EXORpcDataportResource dataportWithName:name format:EXORpcDataportFormatFloat];
            EXORpcCreateRequest *cdp = [EXORpcCreateRequest createWithResource:res complete:^(EXORpcResourceID *RID, NSError *error){
                if (error) {
                    LoggerNetwork(0, @"!!!Error Dataport create for %@ failed %@", alias, error);
                } else {
                    EXORpcMapRequest *map = [EXORpcMapRequest mapWithRID:RID to:alias complete:^(NSError* err){
                        if (err) {
                            LoggerNetwork(0, @"!!!Error Mapping request for %@ to %@ failed %@", alias, RID, err);
                        } else {
                            LoggerNetwork(2, @" Mapped %@ to %@ !", alias, RID);
                        }
                    }];
                    [self.onep doRPCwithAuth:auth requests:@[map] complete:^(NSError *err) {
                        if (err) {
                            LoggerNetwork(0, @"!!!Error on mapping %@ to %@. %@", alias, RID, err);
                        }
                    }];
                }
            }];
            [self.onep doRPCwithAuth:auth requests:@[cdp] complete:^(NSError *err) {
                if (err) {
                    LoggerNetwork(0, @"!!!Error on dataport create for %@. %@", alias, err);
                }
            }];
        } else {
            LoggerNetwork(2, @" Alias %@ is mapped to %@", alias, found);
        }
    }];

    return lkp;
}

- (EXORpcRequest*)uploadScript:(NSString*)alias
{
    EXORpcAuthKey * auth = [EXORpcAuthKey authWithCIK:self.CIK];

    NSURL *url = [[NSBundle mainBundle] URLForResource:alias withExtension:@"lua"];
    NSStringEncoding encoding;
    NSError *error=nil;
    NSString *script = [NSString stringWithContentsOfURL:url usedEncoding:&encoding error:&error];
    if (!script || error) {
        return nil;
    }

    EXORpcLookupRequest *lkp = [EXORpcLookupRequest lookupWithType:EXORpcLookupTypeAlias item:alias complete:^(NSString* found, NSError *err){
        if (err) {
            EXORpcDataruleResource *datarule = [EXORpcDataruleResource dataruleWithName:alias script:script];
            EXORpcCreateRequest *cdp = [EXORpcCreateRequest createWithResource:datarule complete:^(EXORpcResourceID *RID, NSError *error){
                if (error) {
                    LoggerNetwork(0, @"!!!Error Dispatch create for %@ failed %@", alias, error);
                } else {
                    EXORpcMapRequest *map = [EXORpcMapRequest mapWithRID:RID to:alias complete:^(NSError* err){
                        if (err) {
                            LoggerNetwork(0, @"!!!Error Mapping request for %@ to %@ failed %@", alias, RID, err);
                        } else {
                            LoggerNetwork(2, @" Mapped %@ to %@ !", alias, RID);
                        }
                    }];
                    [self.onep doRPCwithAuth:auth requests:@[map] complete:^(NSError *err) {
                        if (err) {
                            LoggerNetwork(0, @"!!!Error on mapping %@ to %@. %@", alias, RID, err);
                        }
                    }];
                }
            }];
            [self.onep doRPCwithAuth:auth requests:@[cdp] complete:^(NSError *err) {
                if (err) {
                    LoggerNetwork(0, @"!!!Error on Datarule create for %@. %@", alias, err);
                }
            }];

        } else {
            LoggerNetwork(2, @"Script has Alias %@ mapped to %@", alias, found);
        }
    }];
    return lkp;
}


- (void)createPortsAndScripts
{
    [self drinkFromCikFountian];

    LoggerNetwork(2, @"Going to create things.");
    self.onep = [EXORpc rpc];

    NSMutableArray *reqs = [NSMutableArray new];
    [reqs addObject:[self makeSureAliasExists:@"rate" name:@"Rate"]];
    [reqs addObject:[self makeSureAliasExists:@"waitforit" name:@"Wait here."]];
    [reqs addObject:[self uploadScript:@"pinging"]];

    EXORpcAuthKey * auth = [EXORpcAuthKey authWithCIK:self.CIK];
    [self.onep doRPCwithAuth:auth requests:[reqs copy] complete:^(NSError *err) {
        if (err) {
            LoggerNetwork(0, @"!!!Error on createPortsAndScripts %@", err);
        }
    }];
}

- (void)setWaitRate:(NSUInteger)seconds
{
    EXORpcWriteRequest *wr = [EXORpcWriteRequest writeWithRID:[EXORpcResourceID resourceIDByAlias:@"rate"] number:@(seconds) complete:^(NSError *error) {
        if (error) {
            LoggerNetwork(0, @"Error writing initial rate! : %@", error);
        }
    }];
    EXORpcAuthKey * auth = [EXORpcAuthKey authWithCIK:self.CIK];
    [self.onep doRPCwithAuth:auth requests:@[wr] complete:^(NSError *err) {
        if (err) {
            LoggerNetwork(0, @"!!!Error on set wait rate %@", err);
        }
    }];
}

- (void)waitForIt:(WaitedForThis)complete
{
    WaitedForThis lcomplete = [complete copy];
    EXORpcResourceID *rid = [EXORpcResourceID resourceIDByAlias:@"waitforit"];
    EXORpcWaitRequest *wr = [EXORpcWaitRequest waitRequestWithRIDs:@[rid] complete:^(NSDictionary *results, NSError *error) {
        EXORpcValue *val = nil;
        if (error) {
            LoggerNetwork(0, @"Error waiting for new data : %@", error);
        } else {
            val = results[rid];
            LoggerNetwork(2, @"Got %@", val);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (lcomplete) {
                lcomplete(val.numberValue, error);
            }
        });
    }];
    EXORpcAuthKey * auth = [EXORpcAuthKey authWithCIK:self.CIK];
    [self.onep doRPCwithAuth:auth requests:@[wr] complete:^(NSError *err) {
        if (err) {
            LoggerNetwork(0, @"!!!Error on waitforit %@", err);
        }
    }];
}

@end
