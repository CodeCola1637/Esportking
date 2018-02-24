//
//  UIImageView+SDWebImage.m
//  esportking
//
//  Created by CKQ on 2018/2/15.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "UIImageView+SDWebImage.h"

@implementation UIImageView (SDWebImage)

- (void)setImageWithUrl:(NSString *)url placeholder:(UIImage *)placeholder
{
    if (url == nil || [url isKindOfClass:[NSNull class]])
    {
        [self setImage:placeholder];
        return;
    }
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder];
}

@end
