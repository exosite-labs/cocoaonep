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
static NSString *EXOPortalNewUserAPI = @"/api/portals/v1/user";
static NSString *EXOPortalResetPasswordAPI = @"/api/portals/v1/user/password";
static NSString *EXOPortalNewDeviceAPI = @"/api/portals/v1/device";

NSString *EXOPortalErrorDomain = @"EXOPortalErrorDomain";

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
            NSError *error = [NSError errorWithDomain:EXOPortalErrorDomain code:kEXOPortalWrongType userInfo:@{NSLocalizedDescriptionKey: @"Expected an Array"}];
            if (lcomplete) {
                lcomplete(nil, error);
            }
            return;
        }
        NSMutableArray *ret = [NSMutableArray new];
        for (NSDictionary *dict in (NSArray*)responseObject) {
            if (![dict isKindOfClass:[NSDictionary class]]) {
                NSError *error = [NSError errorWithDomain:EXOPortalErrorDomain code:kEXOPortalWrongType userInfo:@{NSLocalizedDescriptionKey: @"Expected a Dictionary"}];
                if (lcomplete) {
                    lcomplete(nil, error);
                }
                return;
            }
            EXOPortalDomain *dm = [EXOPortalDomain domainWithDictionary:dict];
            if (dm == nil) {
                NSError *error = [NSError errorWithDomain:EXOPortalErrorDomain code:kEXOPortalParseFailed userInfo:@{NSLocalizedDescriptionKey: @"Failed to parse as domain"}];
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
    
    EXOPortalPortalsBlock lcomplete = [complete copy];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (![responseObject isKindOfClass:[NSArray class]]) {
            NSError *error = [NSError errorWithDomain:EXOPortalErrorDomain code:kEXOPortalWrongType userInfo:@{NSLocalizedDescriptionKey: @"Expected an Array"}];
            if (lcomplete) {
                lcomplete(nil, error);
            }
            return;
        }
        NSMutableArray *ret = [NSMutableArray new];
        for (NSDictionary *dict in (NSArray*)responseObject) {
            if (![dict isKindOfClass:[NSDictionary class]]) {
                NSError *error = [NSError errorWithDomain:EXOPortalErrorDomain code:kEXOPortalWrongType userInfo:@{NSLocalizedDescriptionKey: @"Expected a Dictionary"}];
                if (lcomplete) {
                    lcomplete(nil, error);
                }
                return;
            }
            EXOPortalPortal *dm = [EXOPortalPortal portalWithDictionary:dict];
            if (dm == nil) {
                NSError *error = [NSError errorWithDomain:EXOPortalErrorDomain code:kEXOPortalParseFailed userInfo:@{NSLocalizedDescriptionKey: @"Failed to parse as portal"}];
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

- (void)newUser:(EXOPortalNewUser *)user complete:(EXOPortalBlock)complete
{
    NSOperation *op = [self operationForNewUser:user complete:complete];
    [[NSOperationQueue mainQueue] addOperation:op];
}

- (NSOperation *)operationForNewUser:(EXOPortalNewUser *)user complete:(EXOPortalBlock)complete
{
    NSURL *URL = [NSURL URLWithString:EXOPortalNewUserAPI relativeToURL:self.domain];
    
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    NSError *err=nil;
    NSURLRequest *request = [serializer requestWithMethod:@"POST" URLString:[URL absoluteString] parameters:[user plistValue] error:&err];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    
    EXOPortalBlock lcomplete = [complete copy];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error = nil;
        if (operation.response.statusCode != 200) {
            error = [NSError errorWithDomain:EXOPortalErrorDomain code:operation.response.statusCode userInfo:@{NSLocalizedDescriptionKey: [responseObject description]}];
        }
        if (lcomplete) {
            lcomplete(error);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (lcomplete) {
            lcomplete(error);
        }
    }];
    
    return op;
}

- (void)resetPassword:(NSString *)account complete:(EXOPortalBlock)complete
{
    NSOperation *op = [self operationForResetPassword:account complete:complete];
    [[NSOperationQueue mainQueue] addOperation:op];
}

- (NSOperation *)operationForResetPassword:(NSString *)account complete:(EXOPortalBlock)complete
{
    NSURL *URL = [NSURL URLWithString:EXOPortalResetPasswordAPI relativeToURL:self.domain];
    
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    NSError *err=nil;
    NSDictionary *params = @{@"action":@"reset", @"email": [account copy]};
    NSURLRequest *request = [serializer requestWithMethod:@"POST" URLString:[URL absoluteString] parameters:params error:&err];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    
    EXOPortalBlock lcomplete = [complete copy];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error = nil;
        if (operation.response.statusCode != 200) {
            error = [NSError errorWithDomain:EXOPortalErrorDomain code:operation.response.statusCode userInfo:@{NSLocalizedDescriptionKey: [responseObject description]}];
        }
        if (lcomplete) {
            lcomplete(error);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (lcomplete) {
            lcomplete(error);
        }
    }];
    
    return op;
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p, domain: %@ auth: %@ >", NSStringFromClass([self class]), self, self.domain, self.auth];
}

@end
