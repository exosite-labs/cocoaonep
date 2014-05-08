//
//  EXOBrowseExositeTableViewController.m
//  CocoaOnePExample
//
//  Created by Michael Conrad Tadpol Tilstra on 4/22/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOBrowseExositeTableViewController.h"
#import <EXORpc.h>
#import <Lockbox.h>

@interface EXOBrowseExositeTableViewController ()
@property(strong,nonatomic) EXORpc *onep;
@end

@implementation EXOBrowseExositeTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.onep = [EXORpc rpc];
    self.onep.activityChange = ^(BOOL active){
        [UIApplication sharedApplication].networkActivityIndicatorVisible = active;
    };
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSArray *obj = self.items[indexPath.row];
    cell.textLabel.text = obj[0];
    if ([obj[3] intValue] == 0) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *obj = self.items[indexPath.row];
    NSString *name = obj[0];
    NSString *rid=obj[1];
    NSString *cik=obj[2];

    NSMutableArray *clients = [NSMutableArray new];

    EXORpcAuthKey *auth = [EXORpcAuthKey authWithCIK:cik];
    EXORpcListingRequest *lr = [EXORpcListingRequest listingByType:EXORpcListTypeClient filter:EXORpcFilterTypeAll complete:^(NSDictionary *results, NSError *error) {
        if (error) {
            NSLog(@": listingReq:%@ :error: %@", rid, error);
        } else {
            if ([(NSArray*)results[@"client"] count] > 0) {
                NSMutableArray *calls = [NSMutableArray new];
                for (NSString *rid in results[@"client"]) {
                    EXORpcInfoRequest *infor = [EXORpcInfoRequest infoByRID:[EXORpcResourceID resourceIDByRID:rid] types:(EXORpcInfoRequestTypeDescription | EXORpcInfoRequestTypeKey | EXORpcInfoRequestTypeCounts) complete:^(NSDictionary *results, NSError *error){
                        if (error) {
                            NSLog(@": infoReq:%@ :error: %@", rid, error);
                        } else {
                            [clients addObject:@[results[@"description"][@"name"], rid, results[@"key"], results[@"counts"][@"client"]]];
                        }
                    }];
                    [calls addObject:infor];
                }
                [self.onep doRPCwithAuth:auth requests:calls complete:^(NSError *error) {
                    if (error) {
                        NSLog(@": all infoReqs:%@ :error: %@", rid, error);
                    } else {
                        EXOBrowseExositeTableViewController *dest = [self.storyboard instantiateViewControllerWithIdentifier:@"TADBrowseExositeTableViewControllerID"];
                        dest.items = [clients copy];
                        dest.title = name;
                        [self.navigationController pushViewController:dest animated:YES];
                    }
                }];
            }
        }
    }];

    [self.onep doRPCwithAuth:auth requests:@[lr] complete:^(NSError *error) {
        if (error) {
            NSLog(@" %@", error);
        }
    }];
}

@end
