//
//  CCFetchOrderStrRequest.m
//  esportking
//
//  Created by CKQ on 2018/4/22.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCFetchOrderStrRequest.h"

@implementation CCFetchOrderStrRequest

- (NSString *)subAddress
{
    return FetchOrderStr;
}

- (NSDictionary *)requestParam
{
    return @{
             @"amount":CCNoNilStr(self.amount),
             @"order_number":CCNoNilStr(self.orderID),
             @"pay_type":@(self.payType),
             @"type":@(self.typeWay)
             };
}

@end
