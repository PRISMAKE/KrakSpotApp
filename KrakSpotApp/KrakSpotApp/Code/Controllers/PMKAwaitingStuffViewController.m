//
//  PMKAwaitingStuffViewController.m
//  KrakSpotApp
//
//  Created by Michal Smialko on 28/11/14.
//  Copyright (c) 2014 Prismake. All rights reserved.
//

#import "PMKAwaitingStuffViewController.h"
#import "PRSStyleSheet.h"
#import "PMKAppSettings.h"

const NSTimeInterval STUFF_AUTOMATIC_DISMISS_INTERVAL = 6;
@interface PMKAwaitingStuffViewController ()
@property (nonatomic, strong) NSTimer *dismissTimer;
@end

@implementation PMKAwaitingStuffViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [PRSStyleSheet highlightedBackgroundColor];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.dismissTimer invalidate];
    NSTimeInterval interval = [[PMKAppSettings valueForAppSetting:kStuffVCAutomaticDismissInterval] floatValue];
    self.dismissTimer = [NSTimer scheduledTimerWithTimeInterval:interval
                                                         target:self
                                                       selector:@selector(_dismiss:)
                                                       userInfo:nil
                                                        repeats:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.dismissTimer invalidate];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - PMKAwaitingStuffViewController ()

- (void)_dismiss:(id)sender
{
    [self.navigationController setViewControllers:@[[self.navigationController.viewControllers firstObject]]
                                         animated:YES];
}

- (IBAction)didTapRepeatButton:(id)sender
{
    [self.navigationController setViewControllers:@[[self.navigationController.viewControllers firstObject]]
                                         animated:YES];
}

@end
