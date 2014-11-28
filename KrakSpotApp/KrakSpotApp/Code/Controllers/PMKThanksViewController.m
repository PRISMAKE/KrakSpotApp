#import "PMKThanksViewController.h"
#import "PRSStyleSheet.h"

@interface PMKThanksViewController ()
@property (weak, nonatomic) IBOutlet UIButton *yesButton;
@property (weak, nonatomic) IBOutlet UIButton *noButton;

@end

@implementation PMKThanksViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [PRSStyleSheet configureButtonAppearance:self.yesButton
                                       style:PRSButtonStyleRoundedCorners];
    [PRSStyleSheet configureButtonAppearance:self.noButton
                                       style:PRSButtonStyleRoundedCorners];
}

@end
