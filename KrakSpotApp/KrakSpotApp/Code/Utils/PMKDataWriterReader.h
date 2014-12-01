//
//  PMKDataWriterReader.h
//  KrakSpotApp
//
//  Created by Michal Smialko on 01/12/14.
//  Copyright (c) 2014 Prismake. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMKDataWriterReader : NSObject

+ (void)writeRateWithIdentifier:(NSString *)identifier;
+ (NSArray *)readRates;

@end
