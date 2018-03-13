//
//  CCBindInviteCodeRequest.m
//  esportking
//
//  Created by CKQ on 2018/3/13.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCBindInviteCodeRequest.h"

@implementation CCBindInviteCodeRequest

- (NSString *)subAddress
{
    return BindInviteCode;
}

- (NSDictionary *)requestParam
{
    return @{
             @"invitation_code":CCNoNilStr(self.inviteCode)
             };
}

@end
