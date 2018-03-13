//
//  CCAccountService.m
//  esportking
//
//  Created by CKQ on 2018/2/9.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCAccountService.h"
#import "CCGetInviteCodeRequest.h"

#define kLoginInfo  @"login_info"

@interface CCAccountService ()<CCRequestDelegate>

@property (strong, nonatomic) CCGetInviteCodeRequest *request;

@end

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

- (instancetype)init
{
    if (self = [super init])
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onUserLogin) name:CCLoginNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setUserInfo:(NSDictionary *)dict
{
    _userID = [dict[@"userid"] unsignedIntegerValue]?:_userID;
    _name = CCIsNotNullObj(dict[@"userName"])?dict[@"userName"]:_name;
    _star = CCIsNotNullObj(dict[@"star"])?dict[@"star"]:_star;
    _headUrl = CCIsNotNullObj(dict[@"picture"])?dict[@"picture"]:_headUrl;
    _age = [dict[@"age"] unsignedIntValue]?:_age;
    _coverUrlList = CCIsNotNullObj(dict[@"cover"])?dict[@"cover"]:_coverUrlList;
    _area = CCIsNotNullObj(dict[@"area"])?dict[@"area"]:_area;
    
    _mobile = CCIsNotNullObj(dict[@"mobile"])?dict[@"mobile"]:_mobile;
    _imToken = CCIsNotNullObj(dict[@"im_token"])?dict[@"im_token"]:_imToken;
    _token = CCIsNotNullObj(dict[@"token"])?dict[@"token"]:_token;
    
    id gender = dict[@"gender"];
    if (CCNoNilStr(gender))
    {
        if ([gender isKindOfClass:[NSString class]])
        {
            if ([gender isEqualToString:@"男"])
            {
                _gender = GENDER_BOY;
            }
            else if ([gender isEqualToString:@"女"])
            {
                _gender = GENDER_GIRL;
            }
        }
        else
        {
            _gender = [gender unsignedIntegerValue];
        }
    }
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

#pragma mark - Notification
- (void)onUserLogin
{
    self.request = [CCGetInviteCodeRequest new];
    [self.request startGetRequestWithDelegate:self];
}

#pragma mark - CCRequestDelegate
- (void)onRequestSuccess:(NSDictionary *)dict sender:(id)sender
{
    if (self.request != sender)
    {
        return;
    }
    self.request = nil;
    
    id inviteCode = dict[@"data"][@"invitation_code"];
    id bindInviteCode = dict[@"data"][@"bind_invitation_code"];
    self.inviteCode = CCIsNotNullObj(inviteCode)?inviteCode:nil;
    self.bindInviteCode = CCIsNotNullObj(bindInviteCode)?bindInviteCode:nil;
}

- (void)onRequestFailed:(NSInteger)errorCode errorMsg:(NSString *)msg sender:(id)sender
{
    if (self.request != sender)
    {
        return;
    }
    self.request = nil;
}

@end
