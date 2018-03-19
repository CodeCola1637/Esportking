//
//  CCFetchTagRequest.m
//  esportking
//
//  Created by jaycechen on 2018/3/19.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCFetchTagRequest.h"

@implementation CCFetchTagRequest

- (NSString *)subAddress
{
    return FetchCommentTag;
}

- (NSDictionary *)requestParam
{
    return @{
             @"game_id":@(self.gameID)
             };
}

- (void)decodeData:(NSDictionary *)resp
{
    NSArray *list = resp[@"data"];
    NSMutableArray *array = [NSMutableArray new];
    for (int i=0; i<list.count; i++)
    {
        CCTagModel *model = [[CCTagModel alloc] initWithTagDict:list[i]];
        [array addObject:model];
    }
    self.tagList = array;
}

@end
