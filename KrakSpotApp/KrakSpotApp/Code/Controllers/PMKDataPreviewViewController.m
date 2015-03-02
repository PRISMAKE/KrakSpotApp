//
//  PMKDataPreviewViewController.m
//  KrakSpotApp
//
//  Created by Michal Smialko on 01/12/14.
//  Copyright (c) 2014 Prismake. All rights reserved.
//

#import "PMKDataPreviewViewController.h"
#import "PMKDataWriterReader.h"
#import "PMKAppSettings.h"
#import <MessageUI/MessageUI.h>

NSString * const kDataCellIdentifier = @"kDataCellIdentifier";

@interface PMKDataPreviewViewController () <
UITableViewDataSource,
UITableViewDelegate,
MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic) NSInteger happyCount;
@property (nonatomic) NSInteger okCount;
@property (nonatomic) NSInteger neutralCount;
@property (nonatomic) NSInteger sadCount;
@property (weak, nonatomic) IBOutlet UILabel *happyLabel;
@property (weak, nonatomic) IBOutlet UILabel *okLabel;
@property (weak, nonatomic) IBOutlet UILabel *neutralLabel;
@property (weak, nonatomic) IBOutlet UILabel *sadLabel;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (weak, nonatomic) IBOutlet UILabel *dismissTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *stuffDismissTimeLabel;
@property (weak, nonatomic) IBOutlet UISlider *ASlider;
@property (weak, nonatomic) IBOutlet UISlider *BSlider;
@property (weak, nonatomic) IBOutlet UITextField *mainScreenTitleTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@end

@implementation PMKDataPreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateStyle = NSDateFormatterShortStyle;
    self.dateFormatter.dateFormat = @"hh:mm:ss";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kDataCellIdentifier];
    
    self.dataArray = [PMKDataWriterReader readRates];
    self.happyCount = self.okCount = self.neutralCount = self.sadCount = 0;
    [self.dataArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        NSString *rateId = obj[@"rateId"];
        if ([rateId isEqualToString:kHappyId]) {
            self.happyCount++;
        }
        else if ([rateId isEqualToString:kOkId]) {
            self.okCount++;
        }
        else if ([rateId isEqualToString:kNeutralId]) {
            self.neutralCount++;
        }
        else if ([rateId isEqualToString:kSadId]) {
            self.sadCount++;
        }
    }];
    
    [self _updateView];
}

- (void)_updateView
{
    [self _updateRatesLabels];
    [self _updateTimeLabels];
    [self _updateSliders];
    
    self.mainScreenTitleTextField.text = [PMKAppSettings valueForAppSetting:kMainScreenTitleLabelText];
}

- (void)_updateSliders
{
    NSNumber *AInterval = [PMKAppSettings valueForAppSetting:kThanksVCAutomaticDismissInterval];
    NSNumber *BInterval = [PMKAppSettings valueForAppSetting:kStuffVCAutomaticDismissInterval];
    self.ASlider.value = [AInterval floatValue];
    self.BSlider.value = [BInterval floatValue];
}

- (void)_updateRatesLabels
{
    CGFloat allRatesCount = self.happyCount + self.okCount + self.neutralCount + self.sadCount;
    if (allRatesCount != 0) {
        self.happyLabel.text = [NSString stringWithFormat:@"Happy: %li (%li %%)",
                                (long)self.happyCount, (long)(self.happyCount / allRatesCount * 100)];
        self.okLabel.text = [NSString stringWithFormat:@"Ok: %li (%li %%)",
                             (long)self.okCount, (long)(self.okCount / allRatesCount * 100)];
        self.neutralLabel.text = [NSString stringWithFormat:@"Neutral: %li (%li %%)",
                                  (long)self.neutralCount, (long)(self.neutralCount / allRatesCount * 100)];
        self.sadLabel.text = [NSString stringWithFormat:@"Sad: %li (%li %%)",
                              (long)self.sadCount, (long)(self.sadCount / allRatesCount * 100)];
    }
}

#pragma mark - PMKDataPreviewViewController ()

- (IBAction)_didTapCloseButton:(id)sender
{
    [PMKAppSettings updateAppSetting:kMainScreenTitleLabelText value:self.mainScreenTitleTextField.text];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)_updateTimeLabels
{
    NSNumber *AInterval = [PMKAppSettings valueForAppSetting:kThanksVCAutomaticDismissInterval];
    NSNumber *BInterval = [PMKAppSettings valueForAppSetting:kStuffVCAutomaticDismissInterval];
    
    self.dismissTimeLabel.text = [NSString stringWithFormat:@"'Thanks' dismiss time: %li", (long)[AInterval integerValue]];
    self.stuffDismissTimeLabel.text = [NSString stringWithFormat:@"'Stuff awaiting' dismiss time: %li", (long)[BInterval integerValue]];
}

- (IBAction)didChangeADismissTime:(UISlider *)sender
{
    [PMKAppSettings updateAppSetting:kThanksVCAutomaticDismissInterval value:@(sender.value)];
    [self _updateTimeLabels];
}

- (IBAction)didChangeBDismissTime:(UISlider *)sender
{
    [PMKAppSettings updateAppSetting:kStuffVCAutomaticDismissInterval value:@(sender.value)];
    [self _updateTimeLabels];
}

- (IBAction)_didTapSendButton:(id)sender {
    [PMKDataWriterReader saveRatesToCSVFile:^(NSURL *fileURL) {
        NSString *email = self.emailTextField.text;
        MFMailComposeViewController *mailVC = [[MFMailComposeViewController alloc] init];
        [mailVC setSubject:@"KrakSpot Rates Data"];
        [mailVC setMessageBody:@"KrakSpot Rates." isHTML:NO];
        [mailVC setToRecipients:@[email]];
        NSData *attachmendData = [NSData dataWithContentsOfURL:fileURL];
        [mailVC addAttachmentData:attachmendData mimeType:@"text/csv" fileName:@"rates.csv"];
        mailVC.mailComposeDelegate = self;
        [self presentViewController:mailVC animated:YES completion:nil];
    }];
}


#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kDataCellIdentifier forIndexPath:indexPath];
    
    NSDictionary *rate = self.dataArray[indexPath.row];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[rate[@"timestamp"] floatValue]];
    NSString *dateSting = [self.dateFormatter stringFromDate:date];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ ---- %@", rate[@"rateId"], dateSting];
    
    NSDictionary *imagesNames = @{kHappyId : @"twarz_4",
                                  kOkId : @"twarz_3",
                                  kNeutralId : @"twarz_2",
                                  kSadId : @"twarz_1"};
    NSString *identifier = rate[@"rateId"];
    cell.imageView.image = [UIImage imageNamed:imagesNames[identifier]];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;

    return cell;
}

#pragma mark - <UITableViewDelegate>

#pragma mark - <MFMailComposeViewoControllerDelegate>

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end
