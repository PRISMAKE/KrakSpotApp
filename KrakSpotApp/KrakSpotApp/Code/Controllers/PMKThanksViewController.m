#import "PMKThanksViewController.h"
#import "PRSStyleSheet.h"
#import "PMKAppSettings.h"

@interface PMKThanksViewController ()
@property (weak, nonatomic) IBOutlet UIButton *yesButton;
@property (weak, nonatomic) IBOutlet UIButton *noButton;
@property (nonatomic, strong) NSTimer *dismissTimer;
@end

@implementation PMKThanksViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [PRSStyleSheet lightBackgroundColor];
    
    [PRSStyleSheet configureButtonAppearance:self.yesButton
                                       style:PRSButtonStyleRoundedCorners];
    [PRSStyleSheet configureButtonAppearance:self.noButton
                                       style:PRSButtonStyleRoundedCorners];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.dismissTimer invalidate];
    NSTimeInterval interval = [[PMKAppSettings valueForAppSetting:kThanksVCAutomaticDismissInterval] floatValue];
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

#pragma mark - PMKThanksViewController ()

- (void)_dismiss:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)didTapNoThanksButton:(id)sender
{
    UIViewController *rootVC = [self.navigationController.viewControllers firstObject];
    if (rootVC) {
        [self.navigationController setViewControllers:@[rootVC]
                                             animated:YES];
    }
}

@end
