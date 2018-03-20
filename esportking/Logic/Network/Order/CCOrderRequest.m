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
             @"game_id":@(self.gameID),
             @"status":@(self.status),
             @"pageNumber":@(self.pageNum),
             @"pageSize":@(self.pageSize),
             };
}

- (void)decodeData:(NSDictionary *)resp
{
    NSArray *list = resp[@"data"];
    NSMutableArray *array = [NSMutableArray new];
    for (int i=0; i<list.count; i++)
    {
        CCOrderModel *model = [[CCOrderModel alloc] initWithDict:list[i]];
        [array addObject:model];
    }
    self.orderList = array;
}

@end
