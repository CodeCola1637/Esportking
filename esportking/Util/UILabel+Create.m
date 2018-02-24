//
//  UILabel+Create.m
//  esportking
//
//  Created by CKQ on 2018/2/3.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "UILabel+Create.h"

@implementation UILabel (Create)

+ (UILabel *)createOneLineLabelWithFont:(UIFont *)font color:(UIColor *)color
{
    return [self _createLabelWithFont:font color:color numberOfLines:1];
}

+ (UILabel *)createMultiLineLabelWithFont:(UIFont *)font color:(UIColor *)color
{
    return [self _createLabelWithFont:font color:color numberOfLines:0];
}

+ (UILabel *)_createLabelWithFont:(UIFont *)font color:(UIColor *)color numberOfLines:(uint32_t)num
{
    UILabel *label      = [UILabel new];
    label.textAlignment = NSTextAlignmentCenter;
    label.font          = font;
    label.textColor     = color;
    label.numberOfLines = num;
    return label;
}

@end
