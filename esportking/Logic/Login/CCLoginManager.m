//
//  CCLoginManager.m
//  esportking
//
//  Created by CKQ on 2018/2/4.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCLoginManager.h"
#import "CCLoginRequest.h"

@interface CCLoginManager()<CCRequestDelegate>

@property (weak  , nonatomic) id<CCLoginDelegate> delegate;
@property (strong, nonatomic) CCLoginRequest *request;
@property (strong, nonatomic) void (^saveBlock)(void);

@end

@implementation CCLoginManager

- (instancetype)initWithDel:(id<CCLoginDelegate>)del
{
    if (self = [super init])
    {
        _delegate = del;
    }
    return self;
}

- (void)loginWithMobile:(NSString *)mobile password:(NSString *)password
{
    if (!_request)
    {
        _request = [CCLoginRequest new];
        _request.platform = LOGINTYPE_PHONE;
        _request.mobile = mobile;
        _request.password = password;
        [_request startPostRequestWithDelegate:self];
        
        self.saveBlock = ^{
            NSDictionary *dict = @{
                                   @"loginType":@(LOGINTYPE_PHONE),
                                   @"mobile":CCNoNilStr(mobile),
                                   @"password":CCNoNilStr(password)
                                   };
            [CCAccountServiceInstance saveLoginDict:dict];
        };
    }
}

- (void)loginWithQQToken:(NSString *)token openID:(NSString *)openID
{
    if (!_request)
    {
        _request = [CCLoginRequest new];
        _request.platform = LOGINTYPE_QQ;
        _request.token = token;
        _request.openID = openID;
        [_request startPostRequestWithDelegate:self];
        
        self.saveBlock = ^{
            NSDictionary *dict = @{
                                   @"loginType":@(LOGINTYPE_QQ),
                                   @"token":CCNoNilStr(token),
                                   @"openid":CCNoNilStr(openID)
                                   };
            [CCAccountServiceInstance saveLoginDict:dict];
        };
    }
}

- (void)loginWithWXToken:(NSString *)token openID:(NSString *)openID
{
    if (!_request)
    {
        _request = [CCLoginRequest new];
        _request.platform = LOGINTYPE_WX;
        _request.token = token;
        _request.openID = openID;
        [_request startPostRequestWithDelegate:self];
        
        self.saveBlock = ^{
            NSDictionary *dict = @{
                                   @"loginType":@(LOGINTYPE_WX),
                                   @"token":CCNoNilStr(token),
                                   @"openid":CCNoNilStr(openID)
                                   };
            [CCAccountServiceInstance saveLoginDict:dict];
        };
    }
}

- (void)loginWithInfo:(NSDictionary *)loginInfo
{
    switch ([loginInfo[@"loginType"] unsignedIntValue])
    {
        case LOGINTYPE_PHONE:
        {
            [self loginWithMobile:loginInfo[@"mobile"] password:loginInfo[@"password"]];
        }
            break;
        case LOGINTYPE_QQ:
        {
            [self loginWithQQToken:loginInfo[@"token"] openID:loginInfo[@"openid"]];
        }
            break;
        case LOGINTYPE_WX:
        {
            [self loginWithWXToken:loginInfo[@"token"] openID:loginInfo[@"openid"]];
        }
        default:
            break;
    }
}

#pragma mark - CCRequestDelegate
- (void)onRequestSuccess:(NSDictionary *)dict sender:(id)sender
{
    if (sender != _request)
    {
        return;
    }
    _request = nil;
    self.saveBlock();
    self.saveBlock = nil;
    [self.delegate onLoginSuccess:dict];
}

- (void)onRequestFailed:(NSInteger)errorCode errorMsg:(NSString *)msg sender:(id)sender
{
    if (sender != _request)
    {
        return;
    }
    _request = nil;
    self.saveBlock = nil;
    [self.delegate onLoginFail:errorCode errorMsg:msg];
}

@end
