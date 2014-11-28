//
//  ViewController.m
//  KrakSpotApp
//
//  Created by Michal Smialko on 11/23/14.
//  Copyright (c) 2014 Prismake. All rights reserved.
//

#import "PRSRateViewController.h"
#import "PRSStyleSheet.h"

NSString * const kHappySegue = @"happy";
NSString * const kOkSegue = @"ok";
NSString * const kNeutralSegue = @"neutral";
NSString * const kSadSeque = @"sad";

@interface PRSRateViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *rateButtons;

@end

@implementation PRSRateViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [PRSStyleSheet lightBackgroundColor];
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
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *plistPath = [path stringByAppendingPathComponent:@"data.plist"];
    NSURL *plistURL = [NSURL fileURLWithPath:plistPath];
    
    NSData *data = [NSData dataWithContentsOfURL:plistURL];
    NSArray *plist;
    if (data) {
        plist = [NSPropertyListSerialization propertyListWithData:data
                                                          options:0
                                                           format:NULL
                                                            error:nil];
    }
    if (!plist) {
        plist = @[];
    }
    
    NSDate *now = [NSDate date];
    NSDictionary *rateInfo = @{@"rateId" : rateIdentifier,
                               @"timestamp" : [NSString stringWithFormat:@"%f", [now timeIntervalSince1970]]};
    
    plist = [plist arrayByAddingObject:rateInfo];
    data = [NSPropertyListSerialization dataWithPropertyList:plist
                                                      format:NSPropertyListBinaryFormat_v1_0
                                                     options:0
                                                       error:nil];
    NSError *err;
    BOOL ok = [data writeToURL:plistURL options:NSDataWritingAtomic error:&err];
    
    if (!ok) {
        NSLog(@"Coś poszło nie tak!");
        [[[UIAlertView alloc] initWithTitle:@"Ups" message:@"Coś poszło nie tak :(" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil] show];
    }
}

@end
