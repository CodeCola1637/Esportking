//
//  CCRegisterRequest.m
//  esportking
//
//  Created by CKQ on 2018/2/6.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCRegisterRequest.h"

@implementation CCRegisterRequest

- (NSString *)subAddress
{
    if (self.type == REGISTERTYPE_REGISTER)
    {
        return Register;
    }
    else if (self.type == REGISTERTYPE_RESETPWD)
    {
        return ChangePwd;
    }
    return nil;
}

- (NSDictionary *)requestParam
{
    return @{
             @"mobile":CCNoNilStr(self.phoneNum),
             @"password":CCNoNilStr(self.password),
             @"smsCode":CCNoNilStr(self.smsCode)
             };
}

@end
