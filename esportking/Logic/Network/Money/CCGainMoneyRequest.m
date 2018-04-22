//
//  CCGainMoneyRequest.m
//  esportking
//
//  Created by CKQ on 2018/4/22.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCGainMoneyRequest.h"

@implementation CCGainMoneyRequest

- (NSString *)subAddress
{
    return GainMoney;
}

- (NSDictionary *)requestParam
{
    return @{
             @"account":CCNoNilStr(self.account),
             @"account_type":@(1),
             @"amount":CCNoNilStr(self.amount),
             @"pay_pass":CCNoNilStr(self.payPass)
             };
}

@end
