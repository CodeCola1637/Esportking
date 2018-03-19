//
//  CCFetchUserInfoRequest.m
//  esportking
//
//  Created by jaycechen on 2018/3/19.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCFetchUserInfoRequest.h"

@implementation CCFetchUserInfoRequest

- (NSString *)subAddress
{
    return FetchUserInfo;
}

- (NSDictionary *)requestParam
{
    return @{
             @"userId":@(self.userID)
             };
}

- (void)decodeData:(NSDictionary *)resp
{
    self.userModel = [[CCUserModel alloc] init];
    [self.userModel setUserInfo:resp[@"data"]];
}

@end
