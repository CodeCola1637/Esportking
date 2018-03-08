//
//  CCLoginImgUtil.m
//  esportking
//
//  Created by jaycechen on 2018/3/7.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCLoginImgUtil.h"

@implementation CCLoginImgUtil

+ (UIImage *)getLoginImgForSize:(CGSize)size
{
    CGFloat ratio = size.height/size.width;
    CGFloat ratio1 = 1.78;
    CGFloat ratio2 = 1.96;
    
    NSString *imgName = nil;
    
    if (ABS(ratio-ratio1) < ABS(ratio-ratio2))
    {
        imgName = @"Login_BG_Ratio_178";
    }
    else
    {
        imgName = @"Login_BG_Ratio_196";
    }

    return CCIMG(imgName);
}

@end
