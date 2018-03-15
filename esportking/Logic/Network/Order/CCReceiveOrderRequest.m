//
//  CCReceiveOrderRequest.m
//  esportking
//
//  Created by jaycechen on 2018/3/15.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCReceiveOrderRequest.h"

@implementation CCReceiveOrderRequest

- (NSString *)subAddress
{
    return ReceiveOrder;
}

- (NSDictionary *)requestParam
{
    return @{
             @"order_number":CCNoNilStr(self.orderID)
             };
}

@end
