//
//  UIImageView+Create.m
//  esportking
//
//  Created by jaycechen on 2018/3/5.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "UIImageView+Create.h"

@implementation UIImageView (Create)

+ (UIImageView *)scaleFillImageView
{
    UIImageView *imgView = [UIImageView new];
    [imgView setContentMode:UIViewContentModeScaleAspectFill];
    [imgView setClipsToBounds:YES];
    return imgView;
}

@end
