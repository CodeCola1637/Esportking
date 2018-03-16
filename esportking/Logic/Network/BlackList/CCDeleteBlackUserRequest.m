//
//  CCDeleteBlackUserRequest.m
//  esportking
//
//  Created by jaycechen on 2018/3/16.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCDeleteBlackUserRequest.h"

@implementation CCDeleteBlackUserRequest

- (NSString *)subAddress
{
    return DeleteBlackUser;
}

- (NSDictionary *)requestParam
{
    return @{
             @"otherid":@(self.userID)
             };
}

@end
