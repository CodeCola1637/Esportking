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

- (void)setEnabled:(BOOL)enabled
{
    if (enabled)
    {
        [self setBackgroundColor:BgColor_Yellow];
    }
    else
    {
        [self setBackgroundColor:BgColor_SuperLightGray];
    }
}

@end
