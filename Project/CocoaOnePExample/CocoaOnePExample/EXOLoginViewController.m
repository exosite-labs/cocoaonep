//
//  EXOLoginViewController.m
//  CocoaOnePExample
//
//  Created by Michael Conrad Tadpol Tilstra on 4/22/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "EXOLoginViewController.h"
#import "EXOBrowseExositeTableViewController.h"
#import <Lockbox.h>
#import <EXOPortal.h>

@interface EXOLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UIButton *forgotButton;
@property (weak, nonatomic) IBOutlet UIButton *createButton;

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
    self.forgotButton.enabled = userOk;
    self.createButton.enabled = userOk && passwdOk;

    return YES;
}

#pragma mark - Actions

- (IBAction)signInAction:(id)sender {
    NSString *account = self.accountTextField.text;
    NSString *password = self.passwordTextField.text;

    EXOPortalAuth *auth = [EXOPortalAuth authWithUsername:account password:password];
    EXOPortal *portal = [EXOPortal portalWithAuth:auth];
    [portal portals:^(NSArray *portals, NSError *error){
        if (error) {
            NSLog(@"logintoAccount:password:at:complete: Failed to login: %@", error);
            NSString *ldsc = error.userInfo[NSLocalizedDescriptionKey];
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Login Failed!",) message:ldsc delegate:nil cancelButtonTitle:NSLocalizedString(@"bummer",) otherButtonTitles:nil];
            [av show];

        } else {
            [Lockbox setString:password forKey:account];
            NSMutableArray *item = [NSMutableArray new];
            for (EXOPortalPortal *ptl in portals) {
                [item addObject:@[ptl.name, ptl.rid, ptl.key, @(1)]];
            }
            self.portals = [item copy];

            [self performSegueWithIdentifier:@"browseAccount" sender:self];
        }
    }];

}

- (IBAction)forgotPasswordButton:(id)sender {
    NSString *account = self.accountTextField.text;

    EXOPortal *portal = [EXOPortal portalWithAuth:nil];
    [portal resetPassword:account complete:^(NSError *error) {
        if (error) {
            NSString *ldsc = error.userInfo[NSLocalizedDescriptionKey];
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Failed to Reset Password",) message:ldsc delegate:nil cancelButtonTitle:NSLocalizedString(@"bummer",) otherButtonTitles:nil];
            [av show];
        } else {
            NSString *ldsc = NSLocalizedString(@"You will get an email with the next step to reset your password.",);
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Password Reset",) message:ldsc delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",) otherButtonTitles:nil];
            [av show];
        }
    }];
}

- (IBAction)createAccountButton:(id)sender {
    NSString *account = self.accountTextField.text;
    NSString *password = self.passwordTextField.text;

    EXOPortal *portal = [EXOPortal portalWithAuth:nil];
    EXOPortalNewUser *nu = [EXOPortalNewUser userWithEmail:account password:password plan:@"3676938388"];
    [portal newUser:nu complete:^(NSError *error) {
        if (error) {
            NSString *ldsc = error.userInfo[NSLocalizedDescriptionKey];
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Failed to Create Account",) message:ldsc delegate:nil cancelButtonTitle:NSLocalizedString(@"bummer",) otherButtonTitles:nil];
            [av show];
        } else {
            [Lockbox setString:password forKey:account];

            NSString *ldsc = NSLocalizedString(@"You will get an email with the next step to activate your account.",);
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Account Created",) message:ldsc delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",) otherButtonTitles:nil];
            [av show];
        }
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
