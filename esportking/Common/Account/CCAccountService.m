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
    _userID = [dict[@"userid"] unsignedIntegerValue]?:_userID;
    _name = CCIsNotNullObj(dict[@"userName"])?dict[@"userName"]:_name;
    _gender = dict[@"gender"]?:_gender;
    _star = CCIsNotNullObj(dict[@"star"])?dict[@"star"]:_star;
    _headUrl = CCIsNotNullObj(dict[@"picture"])?dict[@"picture"]:_headUrl;
    _age = [dict[@"age"] unsignedIntValue]?:_age;
    _coverUrlList = CCIsNotNullObj(dict[@"cover"])?dict[@"cover"]:_coverUrlList;
    _area = CCIsNotNullObj(dict[@"area"])?dict[@"area"]:_area;
    
    _mobile = CCIsNotNullObj(dict[@"mobile"])?dict[@"mobile"]:_mobile;
    _imToken = CCIsNotNullObj(dict[@"im_token"])?dict[@"im_token"]:_imToken;
    _token = CCIsNotNullObj(dict[@"token"])?dict[@"token"]:_token;
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
