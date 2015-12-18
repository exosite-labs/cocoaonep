//
//  EXOLoginViewController.m
//  CocoaOnePExample
//
//  Created by Michael Conrad Tadpol Tilstra on 4/22/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOLoginViewController.h"
#import "EXOBrowseExositeTableViewController.h"
#import "Lockbox.h"
#import "AFNetworking.h"

@interface EXOLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;

@property (strong,nonatomic) NSArray *portals;
@end

@implementation EXOLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.accountTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isEqual:self.accountTextField]) {
        [self.passwordTextField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self signInAction:nil];
        });
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField isEqual:self.accountTextField]) {
        NSString *ps = [Lockbox stringForKey:textField.text];
        if (ps.length > 0) {
            self.passwordTextField.text = ps;
            self.signInButton.enabled = YES;
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    BOOL userOk = self.accountTextField.text.length > 4;
    BOOL passwdOk = self.passwordTextField.text.length > 4;

    self.signInButton.enabled = userOk && passwdOk;

    return YES;
}

#pragma mark - Actions

- (IBAction)signInAction:(id)sender {
    NSString *account = self.accountTextField.text;
    NSString *password = self.passwordTextField.text;

    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURL *domain = [NSURL URLWithString:@"https://portals.exosite.com"];
    AFHTTPSessionManager *lsem = [[AFHTTPSessionManager alloc] initWithBaseURL:domain sessionConfiguration:sessionConfig];
    lsem.requestSerializer = [AFJSONRequestSerializer serializer];
    lsem.responseSerializer = [AFJSONResponseSerializer serializer];
    [lsem.requestSerializer setAuthorizationHeaderFieldWithUsername:account password:password];

    

    [lsem GET:@"/api/portals/v1/portal/" parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (![responseObject isKindOfClass:[NSArray class]]) {
            NSError *error = [NSError errorWithDomain:NSStringFromClass([self class]) code:1 userInfo:@{NSLocalizedDescriptionKey: @"Expected an Array"}];
            NSLog(@"logintoAccount:password:at:complete: Failed to login: %@", error);
            NSString *ldsc = error.userInfo[NSLocalizedDescriptionKey];
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Login Failed!",) message:ldsc delegate:nil cancelButtonTitle:NSLocalizedString(@"bummer",) otherButtonTitles:nil];
            [av show];
            return;
        }
        NSMutableArray *ret = [NSMutableArray new];
        for (NSDictionary *dict in (NSArray*)responseObject) {
            if (![dict isKindOfClass:[NSDictionary class]]) {
                NSError *error = [NSError errorWithDomain:NSStringFromClass([self class]) code:2 userInfo:@{NSLocalizedDescriptionKey: @"Expected a Dictionary"}];
                NSLog(@"logintoAccount:password:at:complete: Failed to login: %@", error);
                NSString *ldsc = error.userInfo[NSLocalizedDescriptionKey];
                UIAlertView *av = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Login Failed!",) message:ldsc delegate:nil cancelButtonTitle:NSLocalizedString(@"bummer",) otherButtonTitles:nil];
                [av show];

                return;
            }
            NSArray *dm = @[dict[@"name"], dict[@"rid"], dict[@"key"], @(1)];
            [ret addObject:dm];
        }

        [Lockbox setString:password forKey:account];
        self.portals = [ret copy];
        [self performSegueWithIdentifier:@"browseAccount" sender:self];

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"logintoAccount:password:at:complete: Failed to login: %@", error);
        NSString *ldsc = error.userInfo[NSLocalizedDescriptionKey];
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Login Failed!",) message:ldsc delegate:nil cancelButtonTitle:NSLocalizedString(@"bummer",) otherButtonTitles:nil];
        [av show];
    }];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"browseAccount"]) {
        EXOBrowseExositeTableViewController *vc = segue.destinationViewController;
        vc.items = self.portals;
        vc.title = NSLocalizedString(@"Portals",);
    }
}

@end
