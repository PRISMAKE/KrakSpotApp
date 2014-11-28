//
//  PRSStyleSheet.m
//  KrakSpotApp
//
//  Created by Michal Smialko on 11/23/14.
//  Copyright (c) 2014 Prismake. All rights reserved.
//

#import "PRSStyleSheet.h"

@implementation PRSStyleSheet

#pragma mark + PRSStyleSheet

+ (UIColor *)lightBackgroundColor
{
    return [PRSStyleSheet _uiLightBlue];
}

+ (UIColor  *)highlightedBackgroundColor
{
    return [PRSStyleSheet _uiRed];
}

+ (void)configureButtonAppearance:(UIButton *)button style:(PRSButtonStyle)style
{
    switch (style) {
        case PRSButtonStyleRound:
            button.layer.cornerRadius = button.bounds.size.width/2.f;
            button.backgroundColor = [PRSStyleSheet _uiDarkBlue];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            break;
        case PRSButtonStyleHighlightedRound:
            button.layer.cornerRadius = button.bounds.size.width/2.f;
            button.backgroundColor = [PRSStyleSheet _highlightedButtonBackgroundColor];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            break;
        case PRSButtonStyleRoundedCorners:
            button.layer.cornerRadius = button.bounds.size.height/2.f;
            button.backgroundColor = [PRSStyleSheet _roundedButtonBackgroundColor];
            [button setTitleColor:[PRSStyleSheet _uiLightBlue] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}

#pragma mark + PRSStyleSheet ()

+ (UIColor *)_roundedButtonBackgroundColor
{
    return [UIColor whiteColor];
}

+ (UIColor *)_highlightedButtonBackgroundColor
{
    return [PRSStyleSheet _uiRed];
}

+ (UIColor *)_uiLightBlue
{
    return [UIColor colorWithRed:0.
                           green:191./255.
                            blue:236./255.
                           alpha:1.];
}

+ (UIColor *)_uiDarkBlue
{
    return [UIColor colorWithRed:0.
                           green:149./255.
                            blue:222./255.
                           alpha:1.];
}

+ (UIColor *)_uiRed
{
    return [UIColor colorWithRed:214./255.
                           green:77./255.
                            blue:54./255.
                           alpha:1.];
}


@end
