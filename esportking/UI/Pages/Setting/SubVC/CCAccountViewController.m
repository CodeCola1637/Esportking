//
//  CCAccountViewController.m
//  esportking
//
//  Created by jaycechen on 2018/3/16.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCAccountViewController.h"
#import "CCTitleItem.h"

#import "CCRegisterViewController.h"

#import "CCGetMyBindRequest.h"
#import "CCBindThirdRequest.h"
#import "CCSetPayPwdRequest.h"

#import <ShareSDK/ShareSDK.h>
#import <CYPasswordView/CYPasswordView.h>

@interface CCAccountViewController ()<CCTitleItemDelegate, CCRegisterViewControllerDelegate, CCRequestDelegate>

@property (strong, nonatomic) CCBaseRequest *request;

@property (strong, nonatomic) CCTitleItem *phoneBindItem;
@property (strong, nonatomic) UIView *firstDevideView;
@property (strong, nonatomic) CCTitleItem *passwordItem;
@property (strong, nonatomic) UIView *secondDevideView;
@property (strong, nonatomic) CCTitleItem *wxBindItem;
@property (strong, nonatomic) CCTitleItem *qqBindItem;
@property (strong, nonatomic) CYPasswordView *passView;

@end

@implementation CCAccountViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configTopbar];
    [self configContent];
    [self getBindInfo];
}

- (void)configTopbar
{
    [self addTopPopBackButton];
    [self addTopbarTitle:@"账户与安全"];
}

- (void)configContent
{
    [self setContentWithTopOffset:LMStatusBarHeight+LMTopBarHeight bottomOffset:LMLayoutAreaBottomHeight];
    
    [self.contentView addSubview:self.phoneBindItem];
    [self.contentView addSubview:self.firstDevideView];
    [self.contentView addSubview:self.passwordItem];
    [self.contentView addSubview:self.secondDevideView];
    [self.contentView addSubview:self.wxBindItem];
    [self.contentView addSubview:self.qqBindItem];
    
    [self.phoneBindItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(CCPXToPoint(0));
        make.right.equalTo(self.contentView).offset(-CCPXToPoint(0));
    }];
    [self.firstDevideView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.phoneBindItem.mas_bottom);
        make.height.mas_equalTo(CCPXToPoint(12));
    }];
    [self.passwordItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.phoneBindItem);
        make.top.equalTo(self.firstDevideView.mas_bottom);
    }];
    [self.secondDevideView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.firstDevideView);
        make.top.equalTo(self.passwordItem.mas_bottom);
        make.height.mas_equalTo(CCPXToPoint(12));
    }];
    [self.wxBindItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.phoneBindItem);
        make.top.equalTo(self.secondDevideView.mas_bottom);
    }];
    [self.qqBindItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.phoneBindItem);
        make.top.equalTo(self.wxBindItem.mas_bottom);
    }];
}

- (void)getBindInfo
{
    CCGetMyBindRequest *req = [CCGetMyBindRequest new];
    [req startGetRequestWithDelegate:self];
    self.request = req;
}

#pragma mark - CCTitleItemDelegate
- (void)onClickTitleItem:(id)sender
{
    if (sender == self.phoneBindItem)
    {
        CCRegisterViewController *vc = [[CCRegisterViewController alloc] initWithType:REGISTERTYPE_BINDACCOUNT del:self];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (sender == self.passwordItem)
    {
        if (!CCAccountServiceInstance.hasSetPayPwd)
        {
            CCWeakSelf(weakSelf);
            self.passView = [self createPassView];
            self.passView.finish = ^(NSString *password) {
                [weakSelf onSetPayPwd:password];
            };
            [self.passView showInView:self.view.window];
        }
        else
        {
            [self showToast:@"暂不支持修改支付密码"];
        }
    }
    else if (sender == self.wxBindItem)
    {
        CCWeakSelf(weakSelf);
        [ShareSDK getUserInfo:SSDKPlatformTypeWechat
               onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
         {
             if (state == SSDKResponseStateSuccess)
             {
                 CCBindThirdRequest *req = [CCBindThirdRequest new];
                 req.platform = PLATFORM_QQ;
                 req.token = user.credential.token;
                 req.openID = user.credential.uid;
                 weakSelf.request = req;
                 [req startPostRequestWithDelegate:self];
             }
             else
             {
                 [weakSelf showToast:error.localizedDescription];
             }
         }];
    }
    else if (sender == self.qqBindItem)
    {
        CCWeakSelf(weakSelf);
        [ShareSDK getUserInfo:SSDKPlatformTypeQQ
               onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
         {
             if (state == SSDKResponseStateSuccess)
             {
                 CCBindThirdRequest *req = [CCBindThirdRequest new];
                 req.platform = PLATFORM_WX;
                 req.token = user.credential.token;
                 req.openID = user.credential.uid;
                 weakSelf.request = req;
                 [req startPostRequestWithDelegate:self];
             }
             else
             {
                 [weakSelf showToast:error.localizedDescription];
             }
         }];
    }
}

#pragma mark - CCRegisterViewControllerDelegate
- (void)onRegisterAndBindPhoneSuccess:(NSString *)phoneNum
{
    [self.phoneBindItem.titleLabel setText:[NSString stringWithFormat:@"手机号：%@", phoneNum]];
    [self.phoneBindItem changeSubTitle:@"更换手机号" subTitleColor:FontColor_Black];
}

#pragma mark - CCRequestDelegate
- (void)onRequestSuccess:(NSDictionary *)dict sender:(id)sender
{
    if (sender != self.request)
    {
        return;
    }
    self.request = nil;
    [self endLoading];
    
    if ([sender isKindOfClass:[CCGetMyBindRequest class]])
    {
        CCGetMyBindRequest *req = sender;
        if (req.phone && req.phone.length > 0)
        {
            [self onRegisterAndBindPhoneSuccess:req.phone];
        }
        if (req.wxBinded)
        {
            [self.wxBindItem changeSubTitle:@"已绑定" subTitleColor:FontColor_Black];
        }
        if (req.qqBinded)
        {
            [self.qqBindItem changeSubTitle:@"已绑定" subTitleColor:FontColor_Black];
        }
    }
    else if ([sender isKindOfClass:[CCBindThirdRequest class]])
    {
        CCBindThirdRequest *req = sender;
        if (req.platform == PLATFORM_QQ)
        {
            [self.qqBindItem changeSubTitle:@"已绑定" subTitleColor:FontColor_Black];
        }
        else if (req.platform == PLATFORM_WX)
        {
            [self.wxBindItem changeSubTitle:@"已绑定" subTitleColor:FontColor_Black];
        }
    }
    else if ([sender isKindOfClass:[CCSetPayPwdRequest class]])
    {
        [self.passView stopLoading];
        [self.passView requestComplete:YES message:@"支付密码设置成功"];
        CCAccountServiceInstance.hasSetPayPwd = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.passView hide];
        });
    }
}

- (void)onRequestFailed:(NSInteger)errorCode errorMsg:(NSString *)msg sender:(id)sender
{
    if (sender != self.request)
    {
        return;
    }
    self.request = nil;
    
    if ([sender isKindOfClass:[CCSetPayPwdRequest class]])
    {
        [self.passView stopLoading];
        [self.passView requestComplete:NO message:[NSString stringWithFormat:@"设置支付密码失败:%@", msg]];
    }
    else
    {
        [self endLoading];
        [self showToast:msg];
    }
}
#pragma mark - private
- (void)onSetPayPwd:(NSString *)pwd
{
    [self.passView hideKeyboard];
    [self.passView startLoading];
    CCSetPayPwdRequest *req = [CCSetPayPwdRequest new];
    req.payPwd = pwd;
    self.request = req;
    [self.request startPostRequestWithDelegate:self];
}

#pragma mark - getter
- (CCTitleItem *)phoneBindItem
{
    if (!_phoneBindItem)
    {
        _phoneBindItem = [[CCTitleItem alloc] initWithTitle:@"手机号" subTitle:@"未绑定" subTitleColor:FontColor_Gray delegate:self];
    }
    return _phoneBindItem;
}

- (UIView *)firstDevideView
{
    if (!_firstDevideView)
    {
        _firstDevideView = [UIView new];
        [_firstDevideView setBackgroundColor:BgColor_SuperLightGray];
    }
    return _firstDevideView;
}

- (CCTitleItem *)passwordItem
{
    if (!_passwordItem)
    {
        _passwordItem = [[CCTitleItem alloc] initWithTitle:@"支付密码" subTitle:nil subTitleColor:nil delegate:self];
    }
    return _passwordItem;
}

- (UIView *)secondDevideView
{
    if (!_secondDevideView)
    {
        _secondDevideView = [UIView new];
        [_secondDevideView setBackgroundColor:BgColor_SuperLightGray];
    }
    return _secondDevideView;
}

- (CCTitleItem *)wxBindItem
{
    if (!_wxBindItem)
    {
        _wxBindItem = [[CCTitleItem alloc] initWithTitle:@"微信" subTitle:@"未绑定" subTitleColor:FontColor_Gray delegate:self];
    }
    return _wxBindItem;
}

- (CCTitleItem *)qqBindItem
{
    if (!_qqBindItem)
    {
        _qqBindItem = [[CCTitleItem alloc] initWithTitle:@"QQ" subTitle:@"未绑定" subTitleColor:FontColor_Gray delegate:self];
    }
    return _qqBindItem;
}

- (CYPasswordView *)createPassView
{
    CYPasswordView *passView = [CYPasswordView new];
    passView.title =@"设置支付密码";
    passView.loadingText = @"提交中……";
    return passView;
}

@end
