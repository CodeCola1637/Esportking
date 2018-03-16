//
//  CCLoginViewController.m
//  esportking
//
//  Created by CKQ on 2018/2/4.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCLoginViewController.h"
#import "CCRegisterViewController.h"
#import "AppDelegate.h"

#import "CCTextField.h"
#import "UILabel+Create.h"
#import "CCLoginManager.h"
#import "CCBigButton.h"
#import "CCAccountService.h"
#import "CCLoginImgUtil.h"

#import <ShareSDK/ShareSDK.h>

@interface CCLoginViewController ()<CCLoginDelegate>

@property (strong, nonatomic) CCLoginManager *loginMgr;

@property (strong, nonatomic) UIImageView   *fakeImgView;
@property (strong, nonatomic) UIImageView   *logoImgView;
@property (strong, nonatomic) CCTextField   *phoneInput;
@property (strong, nonatomic) CCTextField   *passwordInput;
@property (strong, nonatomic) UIView        *phoneLineView;
@property (strong, nonatomic) UIView        *passwordLineView;
@property (strong, nonatomic) UILabel       *forgetLabel;
@property (strong, nonatomic) CCBigButton   *loginButton;
@property (strong, nonatomic) UILabel       *noneLable;
@property (strong, nonatomic) UILabel       *registerLabel;
@property (strong, nonatomic) UILabel       *thirdLoginLabel;
@property (strong, nonatomic) UIButton      *wxLoginButton;
@property (strong, nonatomic) UIButton      *qqLoginButton;
@property (strong, nonatomic) UIView        *loginLineView;

@end

@implementation CCLoginViewController

- (instancetype)init
{
    if (self = [super init])
    {
        _loginMgr = [[CCLoginManager alloc] initWithDel:self];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateContent];
    [self setup];
    
    NSDictionary *dict = [CCAccountServiceInstance getLoginDict];
    if (dict != nil)
    {
        [self.view addSubview:self.fakeImgView];
        [self.view bringSubviewToFront:self.fakeImgView];
        [self.fakeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        [_loginMgr loginWithInfo:dict];
    }
}

- (void)updateContent
{
    [self.topbarView setHidden:YES];
    [self setContentWithTopOffset:LMLayoutAreaTopHeight bottomOffset:LMLayoutAreaBottomHeight];
    [self.backgroundImgView setImage:[CCLoginImgUtil getLoginImgForSize:[UIScreen mainScreen].bounds.size]];
}

- (void)setup
{
    [self.contentView addSubview:self.logoImgView];
    [self.contentView addSubview:self.phoneInput];
    [self.contentView addSubview:self.passwordInput];
    [self.contentView addSubview:self.phoneLineView];
    [self.contentView addSubview:self.passwordLineView];
    [self.contentView addSubview:self.loginButton];
    [self.contentView addSubview:self.forgetLabel];
    [self.contentView addSubview:self.noneLable];
    [self.contentView addSubview:self.registerLabel];
    [self.contentView addSubview:self.thirdLoginLabel];
    [self.contentView addSubview:self.wxLoginButton];
    [self.contentView addSubview:self.qqLoginButton];
    [self.contentView addSubview:self.loginLineView];
    
    [self.logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(CCPXToPoint(200));
        make.centerX.equalTo(self.contentView);
    }];
    [self.phoneInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(CCHorMargin);
        make.right.equalTo(self.contentView).offset(-CCHorMargin);
        make.top.equalTo(self.logoImgView.mas_bottom).offset(CCPXToPoint(96));
    }];
    [self.phoneLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.phoneInput);
        make.top.equalTo(self.phoneInput.mas_bottom).offset(CCPXToPoint(30));
        make.height.mas_equalTo(CCOnePoint);
    }];
    [self.passwordInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(CCHorMargin);
        make.right.equalTo(self.contentView).offset(-CCHorMargin);
        make.top.equalTo(self.phoneLineView.mas_bottom).offset(30);
    }];
    [self.passwordLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.passwordInput);
        make.top.equalTo(self.passwordInput.mas_bottom).offset(CCPXToPoint(30));
        make.height.mas_equalTo(CCOnePoint);
    }];
    [self.forgetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.passwordLineView);
        make.top.equalTo(self.passwordLineView.mas_bottom).offset(CCPXToPoint(32));
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView).offset(CCPXToPoint(88));
    }];
    
    UIView *centerView = [UIView new];
    [self.contentView addSubview:centerView];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.loginButton.mas_bottom).offset(CCPXToPoint(64));
    }];
    [self.noneLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(centerView);
    }];
    [self.registerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.noneLable.mas_right);
        make.right.top.equalTo(centerView);
    }];
    
    [self.thirdLoginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-CCPXToPoint(154));
    }];
    
    [self.loginLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-CCPXToPoint(74));
        make.height.mas_equalTo(CCPXToPoint(20));
        make.width.mas_equalTo(CCOnePoint);
    }];
    [self.wxLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.loginLineView);
        make.right.equalTo(self.loginLineView).offset(-CCPXToPoint(75));
        make.size.mas_equalTo(CGSizeMake(CCPXToPoint(48), CCPXToPoint(48)));
    }];
    [self.qqLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.loginLineView);
        make.left.equalTo(self.loginLineView).offset(CCPXToPoint(75));
        make.size.mas_equalTo(CGSizeMake(CCPXToPoint(48), CCPXToPoint(48)));
    }];
}

#pragma mark - Action
- (void)onLoginPhone:(UIButton *)button
{
    [self beginLoading];
    [_loginMgr loginWithMobile:self.phoneInput.text password:self.passwordInput.text];
}

- (void)onLoginQQ:(UIButton *)button
{
    [self beginLoading];
    [self _loginThirdPlatform:SSDKPlatformTypeQQ];
}

- (void)onLoginWX:(UIButton *)button
{
    [self beginLoading];
    [self _loginThirdPlatform:SSDKPlatformTypeWechat];
}

- (void)_loginThirdPlatform:(SSDKPlatformType)platform
{
    CCWeakSelf(weakSelf);
    [ShareSDK getUserInfo:platform
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             switch (platform)
             {
                 case SSDKPlatformTypeQQ:
                 {
                     [weakSelf.loginMgr loginWithQQToken:user.credential.token openID:user.uid];
                     break;
                 }
                 case SSDKPlatformTypeWechat:
                 {
                     [weakSelf.loginMgr loginWithWXToken:user.credential.token openID:user.uid];
                     break;
                 }
                 default:
                     break;
             }
         }
         else
         {
             NSLog(@"%@",error);
         }
     }];
}

- (void)onTapForgetLabel:(UIGestureRecognizer *)gesture
{
    CCRegisterViewController *vc = [[CCRegisterViewController alloc] initWithType:REGISTERTYPE_RESETPWD del:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)onTapRegisterLabel:(UIGestureRecognizer *)gesture
{
    CCRegisterViewController *vc = [[CCRegisterViewController alloc] initWithType:REGISTERTYPE_REGISTER del:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - CCLoginDelegate
- (void)onLoginSuccess:(NSDictionary *)dict
{
    [self endLoading];
    [CCAccountServiceInstance setUserInfo:dict[@"data"]];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate changeToContentPage];
    [[NSNotificationCenter defaultCenter] postNotificationName:CCLoginNotification object:nil];
}

- (void)onLoginFail:(NSInteger)code errorMsg:(NSString *)msg
{
    [self endLoading];
    [self showToast:msg];
    [self.fakeImgView setHidden:YES];
}

#pragma mark - getters
- (UIImageView *)fakeImgView
{
    if (!_fakeImgView)
    {
        CGSize viewSize = [UIApplication sharedApplication].delegate.window.bounds.size;
        NSString *viewOrientation =@"Portrait";//横屏请设置成 @"Landscape"
        NSString *launchImage =nil;
        NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
        for(NSDictionary* dict in imagesDict)
        {
            CGSize imageSize =CGSizeFromString(dict[@"UILaunchImageSize"]);
            if(CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]])
            {
                launchImage = dict[@"UILaunchImageName"];
            }
        }
        _fakeImgView = [[UIImageView alloc] initWithImage:CCIMG(launchImage)];
        [_fakeImgView setContentMode:UIViewContentModeScaleAspectFill];
    }
    return _fakeImgView;
}

- (UIImageView *)logoImgView
{
    if (!_logoImgView)
    {
        _logoImgView = [[UIImageView alloc] initWithImage:CCIMG(@"LOGO")];
    }
    return _logoImgView;
}

- (CCTextField *)phoneInput
{
    if (!_phoneInput)
    {
        _phoneInput = [[CCTextField alloc] init];
        [_phoneInput setKeyboardType:UIKeyboardTypePhonePad];
        [_phoneInput setFont:Font_Large];
        [_phoneInput setTextColor:FontColor_Black];
        [_phoneInput setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:@{NSForegroundColorAttributeName:FontColor_Black}]];
    }
    return _phoneInput;
}

- (CCTextField *)passwordInput
{
    if (!_passwordInput)
    {
        _passwordInput = [[CCTextField alloc] init];
        [_passwordInput setKeyboardType:UIKeyboardTypeASCIICapableNumberPad];
        [_passwordInput setLimitText:20];
        [_passwordInput setFont:Font_Large];
        [_passwordInput setTextColor:FontColor_Black];
        [_passwordInput setSecureTextEntry:YES];
        [_passwordInput setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"密码（6-20位）" attributes:@{NSForegroundColorAttributeName:FontColor_Black}]];
    }
    return _passwordInput;
}

- (UIView *)phoneLineView
{
    if (!_phoneLineView)
    {
        _phoneLineView = [UIView new];
        [_phoneLineView setBackgroundColor:BgColor_LightGray];
    }
    return _phoneLineView;
}

- (UIView *)passwordLineView
{
    if (!_passwordLineView)
    {
        _passwordLineView = [UIView new];
        [_passwordLineView setBackgroundColor:BgColor_LightGray];
    }
    return _passwordLineView;
}

- (UILabel *)forgetLabel
{
    if (!_forgetLabel)
    {
        _forgetLabel = [UILabel createOneLineLabelWithFont:Font_Big color:FontColor_Black];
        [_forgetLabel setText:@"忘记密码？"];
        [_forgetLabel setUserInteractionEnabled:YES];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapForgetLabel:)];
        [_forgetLabel addGestureRecognizer:tapGesture];
    }
    return _forgetLabel;
}

- (CCBigButton *)loginButton
{
    if (!_loginButton)
    {
        _loginButton = [[CCBigButton alloc] init];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(onLoginPhone:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (UILabel *)noneLable
{
    if (!_noneLable)
    {
        _noneLable = [UILabel createOneLineLabelWithFont:Font_Big color:FontColor_Black];
        [_noneLable setText:@"还没有账号？"];
    }
    return _noneLable;
}

- (UILabel *)registerLabel
{
    if (!_registerLabel)
    {
        _registerLabel = [UILabel createOneLineLabelWithFont:Font_Big color:FontColor_Yellow];
        [_registerLabel setText:@"手机号快速注册"];
        [_registerLabel setUserInteractionEnabled:YES];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapRegisterLabel:)];
        [_registerLabel addGestureRecognizer:tapGesture];
    }
    return _registerLabel;
}

- (UILabel *)thirdLoginLabel
{
    if (!_thirdLoginLabel)
    {
        _thirdLoginLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_Black];
    }
    return _thirdLoginLabel;
}

- (UIButton *)wxLoginButton
{
    if (!_wxLoginButton)
    {
        _wxLoginButton = [UIButton new];
        [_wxLoginButton setImage:CCIMG(@"WeChat") forState:UIControlStateNormal];
        [_wxLoginButton addTarget:self action:@selector(onLoginWX:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _wxLoginButton;
}

- (UIButton *)qqLoginButton
{
    if (!_qqLoginButton)
    {
        _qqLoginButton = [UIButton new];
        [_qqLoginButton setImage:CCIMG(@"QQ") forState:UIControlStateNormal];
        [_qqLoginButton addTarget:self action:@selector(onLoginQQ:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _qqLoginButton;
}

- (UIView *)loginLineView
{
    if (!_loginLineView)
    {
        _loginLineView = [UIView new];
        [_loginLineView setBackgroundColor:FontColor_DeepGray];
    }
    return _loginLineView;
}

@end
