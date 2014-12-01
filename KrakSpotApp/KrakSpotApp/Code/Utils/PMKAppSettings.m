//
//  PMKAppSettings.m
//  KrakSpotApp
//
//  Created by Michal Smialko on 01/12/14.
//  Copyright (c) 2014 Prismake. All rights reserved.
//

#import "PMKAppSettings.h"

NSString * const kThanksVCAutomaticDismissInterval = @"kThanksVCAutomaticDismissInterval";
NSString * const kStuffVCAutomaticDismissInterval = @"kStuffVCAutomaticDismissInterval";

@implementation PMKAppSettings

#pragma mark + PMKAppSettings

+ (void)updateAppSetting:(NSString *)settingKey value:(id)value
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:value forKey:settingKey];
    [userDefaults synchronize];
}

+ (id)valueForAppSetting:(NSString *)settingKey
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults valueForKey:settingKey];
}

@end
