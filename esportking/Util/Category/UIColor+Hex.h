//
//  UIColor+Hex.h
//  esportking
//
//  Created by CKQ on 2018/2/4.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

+(UIColor*)colorWithRGBHex:(unsigned long long)hex;
+(UIColor*)colorWithARGBHex:(unsigned long long)hex;
+(UIColor*)colorWithRGBAHex:(unsigned long long)hex;

+(UIColor*)colorWithRGBHexStr:(NSString*)hexStr;
+(UIColor*)colorWithARGBHexStr:(NSString*)hexStr;
+(UIColor*)colorWithRGBAHexStr:(NSString*)hexStr;

@end
