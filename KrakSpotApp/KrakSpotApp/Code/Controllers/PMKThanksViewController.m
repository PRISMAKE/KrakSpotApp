#import "PMKThanksViewController.h"
#import "PRSStyleSheet.h"

@interface PMKThanksViewController ()
@property (weak, nonatomic) IBOutlet UIButton *yesButton;
@property (weak, nonatomic) IBOutlet UIButton *noButton;

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

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - PMKThanksViewController

- (IBAction)didTapNoThanksButton:(id)sender
{
    UIViewController *rootVC = [self.navigationController.viewControllers firstObject];
    if (rootVC) {
        [self.navigationController setViewControllers:@[rootVC]
                                             animated:YES];
    }
}

@end
