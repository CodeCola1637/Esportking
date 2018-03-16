//
//  CCBindThirdRequest.m
//  esportking
//
//  Created by jaycechen on 2018/3/16.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCBindThirdRequest.h"

@implementation CCBindThirdRequest

- (NSString *)subAddress
{
    return BindNumber;
}

- (NSDictionary *)requestParam
{
    return @{
             @"access_token":CCNoNilStr(self.token),
             @"openid":CCNoNilStr(self.openID),
             @"type":@(self.platform)
             };
}

@end
