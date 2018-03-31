//
//  CCSetPayPwdRequest.m
//  esportking
//
//  Created by CKQ on 2018/3/25.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCSetPayPwdRequest.h"

@implementation CCSetPayPwdRequest

- (NSString *)subAddress
{
    return PayPwdSet;
}

- (NSDictionary *)requestParam
{
    return @{
             @"pay_pass":CCNoNilStr(self.payPwd)
             };
}

@end
