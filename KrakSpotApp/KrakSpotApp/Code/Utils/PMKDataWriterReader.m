//
//  PMKDataWriterReader.m
//  KrakSpotApp
//
//  Created by Michal Smialko on 01/12/14.
//  Copyright (c) 2014 Prismake. All rights reserved.
//

#import "PMKDataWriterReader.h"

NSString * const kHappyId = @"happy";
NSString * const kOkId = @"ok";
NSString * const kNeutralId = @"neutral";
NSString * const kSadId = @"sad";

@implementation PMKDataWriterReader

#pragma mark - PMKDataWriterReader

+ (void)writeRateWithIdentifier:(NSString *)identifier
{
    NSDate *now = [NSDate date];
    NSDictionary *rateInfo = @{@"rateId" : identifier,
                               @"timestamp" : [NSString stringWithFormat:@"%f", [now timeIntervalSince1970]]};
    
    // Create new array to save
    NSArray *newDataArray = [PMKDataWriterReader readRates];
    newDataArray = [newDataArray arrayByAddingObject:rateInfo];
    NSData *newData = [NSPropertyListSerialization dataWithPropertyList:newDataArray
                                                                 format:NSPropertyListBinaryFormat_v1_0
                                                                options:0
                                                                  error:nil];
    
    // Write to file
    NSError *err;
    BOOL ok = [newData writeToURL:[PMKDataWriterReader _dataFileURL]
                          options:NSDataWritingAtomic
                            error:&err];
    
    if (!ok) {
        NSLog(@"Coś poszło nie tak!");
    }
}

+ (NSArray *)readRates
{
    NSData *data = [NSData dataWithContentsOfURL:[PMKDataWriterReader _dataFileURL]];
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
    
    return plist;
}

#pragma mark + PMKDataWriterReader ()

+ (NSURL *)_dataFileURL
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *plistPath = [path stringByAppendingPathComponent:@"data.plist"];
    NSURL *plistURL = [NSURL fileURLWithPath:plistPath];
    return plistURL;
}

@end
