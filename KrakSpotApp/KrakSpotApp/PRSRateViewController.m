//
//  ViewController.m
//  KrakSpotApp
//
//  Created by Michal Smialko on 11/23/14.
//  Copyright (c) 2014 Prismake. All rights reserved.
//

#import "PRSRateViewController.h"
#import "PRSStyleSheet.h"
#import "PMKDataWriterReader.h"
#import "PMKAppSettings.h"

@interface PRSRateViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *rateButtons;
@end

@implementation PRSRateViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [PRSStyleSheet lightBackgroundColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.titleLabel.text = [PMKAppSettings valueForAppSetting:kMainScreenTitleLabelText];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *identifier = segue.identifier;
    [self saveRate:identifier];
}

#pragma mark - PMKRateViewController ()

- (void)saveRate:(NSString *)rateIdentifier
{
    [PMKDataWriterReader writeRateWithIdentifier:rateIdentifier];
}

- (IBAction)showData:(id)sender
{
    UIViewController *dataVC = [self.storyboard instantiateViewControllerWithIdentifier:@"dataPreviewVC"];
    
    [self presentViewController:dataVC animated:YES completion:nil];
}

@end
