//
//  PRSStyleSheet.h
//  KrakSpotApp
//
//  Created by Michal Smialko on 11/23/14.
//  Copyright (c) 2014 Prismake. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    PRSButtonStyleRound,
    PRSButtonStyleRoundedCorners,
    PRSButtonStyleHighlightedRound,
} PRSButtonStyle;

@interface PRSStyleSheet : NSObject

+ (UIColor *)lightBackgroundColor;
+ (UIColor *)highlightedBackgroundColor;
+ (void)configureButtonAppearance:(UIButton *)button style:(PRSButtonStyle)style;

@end
