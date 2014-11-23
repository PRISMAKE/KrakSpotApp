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

+ (UIColor  *)lightBackgroundColor
{
    return [PRSStyleSheet _uiBlue];
}

+ (void)configureButtonAppearance:(UIButton *)button style:(PRSButtonStyle)style
{
    switch (style) {
        case PRSButtonStyleRound:
            button.layer.cornerRadius = button.bounds.size.width/2.f;
            button.backgroundColor = [PRSStyleSheet lightBackgroundColor];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            break;
        case PRSButtonStyleHighlightedRound:
            button.layer.cornerRadius = button.bounds.size.width/2.f;
            button.backgroundColor = [PRSStyleSheet _highlightedButtonBackgroundColor];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            break;
        case PRSButtonStyleRoundedCorners:
            button.layer.cornerRadius = 9;
            button.backgroundColor = [PRSStyleSheet _roundedButtonBackgroundColor];
            [button setTitleColor:[PRSStyleSheet _uiBlue] forState:UIControlStateNormal];
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
    return [UIColor redColor];
}

+ (UIColor *)_uiBlue
{
    return [UIColor blueColor];
}

@end
