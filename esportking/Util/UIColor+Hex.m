//
//  UIColor+Hex.m
//  esportking
//
//  Created by CKQ on 2018/2/4.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)

+(UIColor*)colorWithRGBHex:(unsigned long long)hex
{
    CGFloat r = ((hex & 0xFF0000) >> 16) / 255.;
    CGFloat g = ((hex & 0x00FF00) >> 8) / 255.;
    CGFloat b = (hex & 0x0000FF) / 255.;
    return [UIColor colorWithRed:r green:g blue:b alpha:1.];
}
+(UIColor*)colorWithARGBHex:(unsigned long long)hex
{
    CGFloat a = ((hex & 0xFF000000) >> 24) / 255.;
    CGFloat r = ((hex & 0x00FF0000) >> 16) / 255.;
    CGFloat g = ((hex & 0x0000FF00) >> 8) / 255.;
    CGFloat b = (hex & 0x000000FF) / 255.;
    return [UIColor colorWithRed:r green:g blue:b alpha:a];
}
+(UIColor*)colorWithRGBAHex:(unsigned long long)hex
{
    CGFloat r = ((hex & 0xFF000000) >> 24) / 255.;
    CGFloat g = ((hex & 0x00FF0000) >> 16) / 255.;
    CGFloat b = ((hex & 0x0000FF00) >> 8) / 255.;
    CGFloat a = (hex & 0x000000FF) / 255.;
    return [UIColor colorWithRed:r green:g blue:b alpha:a];
}

+(UIColor*)colorWithRGBHexStr:(NSString*)hexStr
{
    if(![hexStr length])
        return nil;
    
    // by pass #
    NSScanner *scanner = [NSScanner scannerWithString:hexStr];
    if([hexStr characterAtIndex:0] == '#')
    {
        [scanner setScanLocation:1];
    }
    
    unsigned long long hex = 0;
    if([scanner scanHexLongLong:&hex])
    {
        return [self colorWithRGBHex:hex];
    }
    return nil;
}
+(UIColor*)colorWithARGBHexStr:(NSString*)hexStr
{
    if(![hexStr length])
        return nil;
    
    // by pass #
    NSScanner *scanner = [NSScanner scannerWithString:hexStr];
    if([hexStr characterAtIndex:0] == '#')
    {
        [scanner setScanLocation:1];
    }
    
    unsigned long long hex = 0;
    if([scanner scanHexLongLong:&hex])
    {
        return [self colorWithARGBHex:hex];
    }
    return nil;
}
+(UIColor*)colorWithRGBAHexStr:(NSString*)hexStr
{
    if(![hexStr length])
        return nil;
    
    // by pass #
    NSScanner *scanner = [NSScanner scannerWithString:hexStr];
    if([hexStr characterAtIndex:0] == '#')
    {
        [scanner setScanLocation:1];
    }
    unsigned long long hex = 0;
    if([scanner scanHexLongLong:&hex])
    {
        return [self colorWithRGBAHex:hex];
    }
    return nil;
}
-(UIImage*)coloredImage
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
