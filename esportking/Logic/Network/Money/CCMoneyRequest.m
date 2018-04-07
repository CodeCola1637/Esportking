//
//  CCMoneyRequest.m
//  esportking
//
//  Created by jaycechen on 2018/2/28.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCMoneyRequest.h"

@implementation CCMoneyRequest

- (NSString *)subAddress
{
    return QueryMoney;
}

- (NSDictionary *)requestParam
{
    return @{
             @"type":@(self.type),
             @"pageNumber":@(self.pageIndex),
             @"pageSize":@(20)
             };
}

- (void)decodeData:(NSDictionary *)resp
{
    self.moneyList = resp[@"data"];
}

@end
