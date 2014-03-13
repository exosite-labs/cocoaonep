//
//  EXOPortal.m
//
//  Created by Michael Conrad Tadpol Tilstra on 3/13/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//
//

#import "EXOPortal.h"
#import <AFNetworking.h>

static NSString *EXOPortalDomainAPI = @"/api/portals/v1/domain/";
static NSString *EXOPortalPortalsAPI = @"/api/portals/v1/portal/";

@interface EXOPortal ()
@property(copy,nonatomic) NSURL *domain;
@property(copy,nonatomic) EXOPortalAuth *auth;
@end

@implementation EXOPortal

+ (EXOPortal *)portalWithAuth:(EXOPortalAuth *)auth
{
    return [[EXOPortal alloc] initWithAuth:auth domain:nil];
}

+ (EXOPortal *)portalWithAuth:(EXOPortalAuth *)auth domain:(NSURL *)domain
{
    return [[EXOPortal alloc] initWithAuth:auth domain:domain];
}

- (id)init
{
    return nil;
}

- (instancetype)initWithAuth:(EXOPortalAuth *)auth domain:(NSURL *)domain
{
    if (self = [super init]) {
        self.auth = auth;
        self.domain = domain;
    }
    return self;
}

- (void)domains:(EXOPortalDomainsBlock)complete
{
    NSOperation *op = [self operationForDomains:complete];
    [[NSOperationQueue mainQueue] addOperation:op];
}

- (NSOperation *)operationForDomains:(EXOPortalDomainsBlock)complete
{
    NSURL *URL = [NSURL URLWithString:EXOPortalDomainAPI relativeToURL:self.domain];
    
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    [serializer setAuthorizationHeaderFieldWithUsername:self.auth.username password:self.auth.password];
    NSError *err=nil;
    NSURLRequest *request = [serializer requestWithMethod:@"GET" URLString:[URL absoluteString] parameters:nil error:&err];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    
    EXOPortalDomainsBlock lcomplete = [complete copy];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (![responseObject isKindOfClass:[NSArray class]]) {
            NSError *error = [NSError errorWithDomain:@" " code:1 userInfo:nil]; // FIXME: get real errors.
            if (lcomplete) {
                lcomplete(nil, error);
            }
            return;
        }
        NSMutableArray *ret = [NSMutableArray new];
        for (NSDictionary *dict in (NSArray*)responseObject) {
            if (![dict isKindOfClass:[NSDictionary class]]) {
                NSError *error = [NSError errorWithDomain:@" " code:1 userInfo:nil]; // FIXME: get real errors.
                if (lcomplete) {
                    lcomplete(nil, error);
                }
                return;
            }
            EXOPortalDomain *dm = [EXOPortalDomain domainWithDictionary:dict];
            if (dm == nil) {
                // parse error.
                NSError *error = [NSError errorWithDomain:@" " code:1 userInfo:nil]; // FIXME: get real errors.
                if (lcomplete) {
                    lcomplete(nil, error);
                }
                return;
            }
            [ret addObject:dm];
        }
        if (lcomplete) {
            lcomplete([ret copy], nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (lcomplete) {
            lcomplete(nil, error);
        }
    }];

    return op;
}

- (void)portals:(EXOPortalPortalsBlock)complete
{
    NSOperation *op = [self operationForPortals:complete];
    [[NSOperationQueue mainQueue] addOperation:op];
}

- (NSOperation *)operationForPortals:(EXOPortalPortalsBlock)complete
{
    NSURL *URL = [NSURL URLWithString:EXOPortalPortalsAPI relativeToURL:self.domain];
    
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    [serializer setAuthorizationHeaderFieldWithUsername:self.auth.username password:self.auth.password];
    NSError *err=nil;
    NSURLRequest *request = [serializer requestWithMethod:@"GET" URLString:[URL absoluteString] parameters:nil error:&err];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    
    EXOPortalDomainsBlock lcomplete = [complete copy];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (![responseObject isKindOfClass:[NSArray class]]) {
            NSError *error = [NSError errorWithDomain:@" " code:1 userInfo:nil]; // FIXME: get real errors.
            if (lcomplete) {
                lcomplete(nil, error);
            }
            return;
        }
        NSMutableArray *ret = [NSMutableArray new];
        for (NSDictionary *dict in (NSArray*)responseObject) {
            if (![dict isKindOfClass:[NSDictionary class]]) {
                NSError *error = [NSError errorWithDomain:@" " code:1 userInfo:nil]; // FIXME: get real errors.
                if (lcomplete) {
                    lcomplete(nil, error);
                }
                return;
            }
            EXOPortalPortal *dm = [EXOPortalPortal portalWithDictionary:dict];
            if (dm == nil) {
                // parse error.
                NSError *error = [NSError errorWithDomain:@" " code:1 userInfo:nil]; // FIXME: get real errors.
                if (lcomplete) {
                    lcomplete(nil, error);
                }
                return;
            }
            [ret addObject:dm];
        }
        if (lcomplete) {
            lcomplete([ret copy], nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (lcomplete) {
            lcomplete(nil, error);
        }
    }];
    
    return op;
}

@end
