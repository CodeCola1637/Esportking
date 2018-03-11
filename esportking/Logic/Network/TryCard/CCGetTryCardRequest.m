//
//  CCTryCardRequest.m
//  esportking
//
//  Created by jaycechen on 2018/3/1.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCGetTryCardRequest.h"

@implementation CCGetTryCardRequest

- (NSString *)subAddress
{
    return GetTryCard;
}

- (NSDictionary *)requestParam
{
    return @{
             @"pageSize":@(self.pageNumber),
             @"pageNumber":@(self.pageIndex)
             };
}

- (void)decodeData:(NSDictionary *)resp
{
    NSArray *list = resp[@"data"];
    NSMutableArray *array = [NSMutableArray new];
    for (int i=0; i<list.count; i++)
    {
        [array addObject:[[CCTryCardModel alloc] initWithDict:list[i]]];
    }
    _cardList = array;
}

@end
