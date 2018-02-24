//
//  UILabel+Create.h
//  esportking
//
//  Created by CKQ on 2018/2/3.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Create)

+ (UILabel *)createOneLineLabelWithFont:(UIFont *)font color:(UIColor *)color;
+ (UILabel *)createMultiLineLabelWithFont:(UIFont *)font color:(UIColor *)color;

@end
