//
//  CCCancelOrderRequest.m
//  esportking
//
//  Created by jaycechen on 2018/3/15.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCCancelOrderRequest.h"

@implementation CCCancelOrderRequest

- (NSString *)subAddress
{
    return CancelOrder;
}

- (NSDictionary *)requestParam
{
    return @{
             @"order_number":CCNoNilStr(self.orderID)
             };
}

@end
