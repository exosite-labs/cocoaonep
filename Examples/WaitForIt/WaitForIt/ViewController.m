//
//  ViewController.m
//  WaitForIt
//
//  Created by Michael Conrad Tadpol Tilstra on 12/11/14.
//  Copyright (c) 2014 Exosite. All rights reserved.
//

#import "ViewController.h"
#import "WaitForItWorker.h"

@interface ViewController ()
@property (weak,nonatomic) IBOutlet UIButton *setupButton;
@property (weak,nonatomic) IBOutlet UILabel *waitedLabel;
@property (weak,nonatomic) IBOutlet UILabel *rateLabel;
@property (weak,nonatomic) IBOutlet UISlider *rateSlider;

@property (strong,nonatomic) WaitForItWorker *waiter;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.waiter = [WaitForItWorker new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    self.setupButton.enabled = !self.waiter.isSetup;
    self.waitedLabel.text = @"";
    self.rateLabel.text = [NSString stringWithFormat:@"%u", (unsigned int)self.rateSlider.value];
}

- (void)letsWait {
    if ([[UIApplication sharedApplication] applicationState] != UIApplicationStateActive) {
        return;
    }

    [self.waiter waitForIt:^(NSNumber *number, NSError *error) {
        if (number) {
            self.waitedLabel.text = [NSString stringWithFormat:@"%u", number.intValue];
        } else if (error) {
            self.waitedLabel.text = [error description];
        }
        self.waitedLabel.backgroundColor = [UIColor redColor];
        [UIView animateWithDuration:0.9 animations:^{
            // want to have it pulse red when updated.
            // Doesn't look like this is the right way. so How?
            self.waitedLabel.backgroundColor = [UIColor whiteColor];
        }];
        [self letsWait];
    }];
}

#pragma mark - Actions

- (IBAction)doSetup:(id)sender {
    [self.waiter createPortsAndScripts];
    self.setupButton.enabled = !self.waiter.isSetup;
    [self performSelector:@selector(letsWait) withObject:nil afterDelay:4];
}

- (IBAction)updateSlider:(UISlider*)sender {
    self.rateLabel.text = [NSString stringWithFormat:@"%u", (unsigned int)sender.value];
}

- (IBAction)endSlider:(UISlider*)sender {
    [self.waiter setWaitRate:sender.value];
}

@end
