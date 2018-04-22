//
//  NSString+MD5.m
//  esportking
//
//  Created by CKQ on 2018/4/22.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "NSString+MD5.h"
#import<CommonCrypto/CommonDigest.h>

@implementation NSString (MD5)

- (NSString *)md5Str;
{
    // 1. 将字符串转化为c语言字符串
    const char *cString = [self UTF8String];
    CC_LONG length = (CC_LONG)strlen(cString);
    unsigned char bytes[CC_MD5_DIGEST_LENGTH];
    // 2. 将c的字符串转化为 MD5
    CC_MD5(cString, length, bytes);
    // 3. 将c的字符串转换成oc的
    NSMutableString *finalString = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < 16; i++) {
        // 两位, 前面不足位, 用0补齐
        [finalString appendFormat:@"%02x", bytes[i]];
    }
    return [finalString uppercaseString];
}

@end
