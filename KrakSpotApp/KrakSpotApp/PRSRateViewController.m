//
//  ViewController.m
//  KrakSpotApp
//
//  Created by Michal Smialko on 11/23/14.
//  Copyright (c) 2014 Prismake. All rights reserved.
//

#import "PRSRateViewController.h"
#import "PRSStyleSheet.h"

@interface PRSRateViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *rateButtons;

@end

@implementation PRSRateViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [PRSStyleSheet lightBackgroundColor];
    [self.rateButtons enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL *stop) {
        [PRSStyleSheet configureButtonAppearance:obj
                                           style:PRSButtonStyleRound];
    }];
}

@end
