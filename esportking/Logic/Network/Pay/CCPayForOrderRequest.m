//
//  CCPayForOrderRequest.m
//  esportking
//
//  Created by jaycechen on 2018/3/20.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCPayForOrderRequest.h"

@implementation CCPayForOrderRequest

- (NSString *)subAddress
{
    return PayForOrder;
}

- (NSDictionary *)requestParam
{
    NSString *moneyStr = [NSString stringWithFormat:@"%.2f", self.money];
    return @{
             @"order_number":CCNoNilStr(self.orderID),
             @"amount":CCNoNilStr(moneyStr),
             @"pay_pass":CCNoNilStr(self.payPwd)
             };
}

@end
