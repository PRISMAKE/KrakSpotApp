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


@end
