//
//  PMKAwaitingStuffViewController.m
//  KrakSpotApp
//
//  Created by Michal Smialko on 28/11/14.
//  Copyright (c) 2014 Prismake. All rights reserved.
//

#import "PMKAwaitingStuffViewController.h"
#import "PRSStyleSheet.h"

@interface PMKAwaitingStuffViewController ()

@end

@implementation PMKAwaitingStuffViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [PRSStyleSheet highlightedBackgroundColor];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - PMKAwaitingStuffViewController

- (IBAction)didTapRepeatButton:(id)sender
{
    [self.navigationController setViewControllers:@[[self.navigationController.viewControllers firstObject]]
                                         animated:YES];
}

@end
