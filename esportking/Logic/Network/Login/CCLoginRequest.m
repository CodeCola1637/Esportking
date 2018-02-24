//
//  CCLoginRequest.m
//  esportking
//
//  Created by CKQ on 2018/2/4.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCLoginRequest.h"

@implementation CCLoginRequest

- (NSString *)subAddress
{
    if (PLATFORM_PHONE == self.platform)
    {
        return PhoneLogin;
    }
    else
    {
        return ThirdLogin;
    }
}

- (NSDictionary *)requestParam
{
    if (PLATFORM_PHONE == self.platform)
    {
        return @{
                 @"mobile":CCNoNilStr(self.mobile),
                 @"password":CCNoNilStr(self.password)
                 };
    }
    else
    {
        return @{
                 @"access_token":CCNoNilStr(self.token),
                 @"openid":CCNoNilStr(self.openID),
                 @"type":@(self.platform)
                 };
    }
}

@end
