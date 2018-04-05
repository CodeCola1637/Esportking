//
//  CCCommitButton.m
//  esportking
//
//  Created by jaycechen on 2018/3/19.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCCommitButton.h"

@implementation CCCommitButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setBackgroundColor:BgColor_Yellow];
        [self setTitleColor:FontColor_Black forState:UIControlStateNormal];
        [self setTitleColor:FontColor_Gray forState:UIControlStateDisabled];
    }
    return self;
}

- (void)setEnableTitleColor:(UIColor *)enableTitleColor
{
    [self setTitleColor:enableTitleColor?:FontColor_Black forState:UIControlStateNormal];
}

- (void)setDisableTitleColor:(UIColor *)disableTitleColor
{
    [self setTitleColor:disableTitleColor?:FontColor_Gray forState:UIControlStateDisabled];
}

- (void)setEnabled:(BOOL)enabled
{
    if (enabled)
    {
        [self setBackgroundColor:self.enableColor?:BgColor_Yellow];
    }
    else
    {
        [self setBackgroundColor:self.disableColor?:BgColor_SuperLightGray];
    }
}

@end
