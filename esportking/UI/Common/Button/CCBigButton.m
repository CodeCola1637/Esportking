//
//  CCBigButton.m
//  esportking
//
//  Created by CKQ on 2018/2/6.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCBigButton.h"

@implementation CCBigButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self.layer setCornerRadius:3];
        [self setBackgroundColor:BgColor_Yellow];
        [self.titleLabel setFont:Font_Large];
        [self.titleLabel setTextColor:FontColor_White];
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(BigButtonSize);
        }];
    }
    return self;
}

@end
