//
//  CCNearbyRequest.m
//  esportking
//
//  Created by CKQ on 2018/3/11.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCNearbyRequest.h"

@implementation CCNearbyRequest

- (NSString *)subAddress
{
    return Nearby;
}

- (NSDictionary *)requestParam
{
    return @{
             @"game_id":@(self.gameID),
             @"lon":CCNoNilStr(self.longitude),
             @"lat":CCNoNilStr(self.latitude)
             };
}

- (void)decodeData:(NSDictionary *)resp
{
    NSArray *list = resp[@"data"];
    NSMutableArray *array = [NSMutableArray new];
    for (int i=0; i<list.count; i++)
    {
        CCGameModel *model = [CCGameModel new];
        [model setGameInfo:list[i]];
        [array addObject:model];
    }
    _userList = array;
}

@end
