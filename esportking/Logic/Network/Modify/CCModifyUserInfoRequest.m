//
//  CCModifyUserInfoRequest.m
//  esportking
//
//  Created by CKQ on 2018/2/8.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCModifyUserInfoRequest.h"

@implementation CCModifyUserInfoRequest

- (NSString *)subAddress
{
    return ModifyUser;
}

- (NSDictionary *)requestParam
{
    return @{
             @"userName":CCNoNilStr(self.name),
             @"birthday":CCNoNilStr(self.birth),
             @"gender":@(self.gender)
             };
}

@end
