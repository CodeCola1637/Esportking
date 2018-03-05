//
//  CCOrderRequest.m
//  esportking
//
//  Created by jaycechen on 2018/2/28.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCOrderRequest.h"

@implementation CCOrderRequest

- (NSString *)subAddress
{
    return GetOrder;
}

- (NSDictionary *)requestParam
{
    return @{
             @"type":@(self.type),
             @"game_id":@(self.type),
             @"status":@(0),
             @"pageNumber":@(self.pageNum),
             @"pageSize":@(self.pageSize),
             };
}

@end
