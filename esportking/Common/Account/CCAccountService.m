//
//  CCAccountService.m
//  esportking
//
//  Created by CKQ on 2018/2/9.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCAccountService.h"

#define kLoginInfo  @"login_info"

@implementation CCAccountService

+ (instancetype)shareInstance
{
    static CCAccountService *service;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[CCAccountService alloc] init];
    });
    return service;
}

- (void)setUserInfo:(NSDictionary *)dict
{
    _userID = [dict[@"userid"] unsignedIntegerValue];
    _name = dict[@"userName"];
    _gender = dict[@"gender"];
    _star = dict[@"star"];
    _headUrl = dict[@"picture"];
    _age = [dict[@"age"] unsignedIntValue];
    
    _mobile = dict[@"mobile"];
    _imToken = dict[@"im_token"];
    _token = dict[@"token"];
}

- (void)saveLoginDict:(NSDictionary *)dict
{
    if (dict != nil)
    {
        [[NSUserDefaults standardUserDefaults] setObject:dict forKey:kLoginInfo];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kLoginInfo];
    }
}

- (NSDictionary *)getLoginDict
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLoginInfo];
}

@end
