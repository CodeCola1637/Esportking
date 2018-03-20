//
//  CCOrderDetailRequest.m
//  esportking
//
//  Created by jaycechen on 2018/3/20.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCOrderDetailRequest.h"

@implementation CCOrderDetailRequest

- (NSString *)subAddress
{
    return OrderDetail;
}

-(NSDictionary *)requestParam
{
    return @{
             @"order_number":CCNoNilStr(self.orderID)
             };
}

- (void)decodeData:(NSDictionary *)resp
{
    self.orderModel = [[CCOrderModel alloc] initWithDict:resp[@"data"]];
}

@end
