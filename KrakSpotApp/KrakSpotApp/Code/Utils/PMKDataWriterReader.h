//
//  PMKDataWriterReader.h
//  KrakSpotApp
//
//  Created by Michal Smialko on 01/12/14.
//  Copyright (c) 2014 Prismake. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kHappyId;
extern NSString * const kOkId;
extern NSString * const kNeutralId;
extern NSString * const kSadId;

@interface PMKDataWriterReader : NSObject

+ (void)saveRatesToCSVFile:(void (^)(NSURL *fileURL))complectionHandler;
+ (void)writeRateWithIdentifier:(NSString *)identifier;
+ (NSArray *)readRates;

@end
