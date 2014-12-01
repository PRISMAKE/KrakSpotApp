//
//  PMKAppSettings.h
//  KrakSpotApp
//
//  Created by Michal Smialko on 01/12/14.
//  Copyright (c) 2014 Prismake. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kThanksVCAutomaticDismissInterval;
extern NSString * const kStuffVCAutomaticDismissInterval;

@interface PMKAppSettings : NSObject

+ (void)updateAppSetting:(NSString *)settingKey value:(id)value;
+ (id)valueForAppSetting:(NSString *)settingKey;

@end
