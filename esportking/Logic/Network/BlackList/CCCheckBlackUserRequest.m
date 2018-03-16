//
//  CCCheckBlackUserRequest.m
//  esportking
//
//  Created by jaycechen on 2018/3/16.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCCheckBlackUserRequest.h"

@implementation CCCheckBlackUserRequest

- (NSString *)subAddress
{
    return CheckBlackUser;
}

- (NSDictionary *)requestParam
{
    return @{
             @"otherid":@(self.userID)
             };
}

- (void)decodeData:(NSDictionary *)resp
{
    self.isBlackUser = [resp[@"data"] boolValue];
}

@end
