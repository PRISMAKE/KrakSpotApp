//
//  PMKDataPreviewViewController.m
//  KrakSpotApp
//
//  Created by Michal Smialko on 01/12/14.
//  Copyright (c) 2014 Prismake. All rights reserved.
//

#import "PMKDataPreviewViewController.h"

NSString * const kDataCellIdentifier = @"kDataCellIdentifier";

@interface PMKDataPreviewViewController () <
UITableViewDataSource,
UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PMKDataPreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kDataCellIdentifier];
}

#pragma mark - PMKDataPreviewViewController ()

- (IBAction)_didTapCloseButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kDataCellIdentifier forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - <UITableViewDelegate>

@end
