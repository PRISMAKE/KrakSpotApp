//
//  PMKDataPreviewViewController.m
//  KrakSpotApp
//
//  Created by Michal Smialko on 01/12/14.
//  Copyright (c) 2014 Prismake. All rights reserved.
//

#import "PMKDataPreviewViewController.h"
#import "PMKDataWriterReader.h"

NSString * const kDataCellIdentifier = @"kDataCellIdentifier";

@interface PMKDataPreviewViewController () <
UITableViewDataSource,
UITableViewDelegate>

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
    
    [self _updateLabels];
}

- (void)_updateLabels
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
    [self dismissViewControllerAnimated:YES completion:nil];
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
    return cell;
}

#pragma mark - <UITableViewDelegate>

@end
