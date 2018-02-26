//
//  CCUserDetailRequest.m
//  esportking
//
//  Created by CKQ on 2018/2/25.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCUserDetailRequest.h"

@implementation CCUserDetailRequest

- (NSString *)subAddress
{
    return GetDetailInfo;
}

- (NSDictionary *)requestParam
{
    return @{
             @"user_game_id":@(self.userGameID),
             @"user_id":@(self.userID),
             @"game_id":@(self.gameID)
             };
}

@end
