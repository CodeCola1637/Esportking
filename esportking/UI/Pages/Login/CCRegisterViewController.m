//
//  CCRegisterViewController.m
//  esportking
//
//  Created by CKQ on 2018/2/4.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCRegisterViewController.h"
#import "CCModifyUserInfoViewController.h"

#import "CCRegisterManager.h"

#import "CCBigTextFieldView.h"
#import "CCBigButton.h"
#import "NSString+Check.h"
#import "CCLoginImgUtil.h"

@interface CCRegisterViewController ()<CCRegisterDelegate>

@property (strong, nonatomic) CCRegisterManager     *manager;
@property (strong, nonatomic) NSTimer               *smsTimer;
@property (assign, nonatomic) uint32_t              fireCount;

@property (assign, nonatomic) REGISTERTYPE          type;
@property (strong, nonatomic) UIView                *devideView;
@property (strong, nonatomic) CCTextField           *mobileField;
@property (strong, nonatomic) UIButton              *getSMSCodeButton;
@property (strong, nonatomic) UIView                *lineView;
@property (strong, nonatomic) CCBigTextFieldView    *verfyTextField;
@property (strong, nonatomic) CCBigTextFieldView    *pwdTextField;
@property (strong, nonatomic) CCBigTextFieldView    *confirmPwdTextField;
@property (strong, nonatomic) CCBigButton           *confirmButton;

@end

@implementation CCRegisterViewController

- (instancetype)initWithType:(REGISTERTYPE)type
{
    if (self = [super init])
    {
        self.type = type;
        _manager = [[CCRegisterManager alloc] initWithType:type delegate:self];
    }
    return self;
}

- (void)dealloc
{
    [self stopSMSTimer];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configTopbar];
    [self configOffset];
    [self setupContent];
}

- (void)configTopbar
{
    [self addTopPopBackButton];
    [self addTopbarTitle:[self getTitle]];
}

- (void)configOffset
{
    [self setContentWithTopOffset:LMStatusBarHeight+LMTopBarHeight bottomOffset:LMLayoutAreaBottomHeight];
}

- (void)setupContent
{
    [self.backgroundImgView setImage:[CCLoginImgUtil getLoginImgForSize:[UIScreen mainScreen].bounds.size]];
    
    [self.contentView addSubview:self.devideView];
    [self.contentView addSubview:self.mobileField];
    [self.contentView addSubview:self.getSMSCodeButton];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.verfyTextField];
    [self.contentView addSubview:self.pwdTextField];
    [self.contentView addSubview:self.confirmPwdTextField];
    [self.contentView addSubview:self.confirmButton];
    
    [self.devideView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(CCPXToPoint(16));
    }];
    [self.mobileField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.devideView.mas_bottom).offset(CCPXToPoint(40));
        make.left.equalTo(self.contentView).offset(CCHorMargin);
        make.right.equalTo(self.getSMSCodeButton).offset(-CCHorMargin);
    }];
    [self.getSMSCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mobileField);
        make.right.equalTo(self.contentView).offset(-CCHorMargin);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mobileField.mas_bottom).offset(CCPXToPoint(40));
        make.left.equalTo(self.contentView).offset(CCHorMargin);
        make.right.equalTo(self.contentView).offset(-CCHorMargin);
        make.height.mas_equalTo(CCOnePoint);
    }];
    [self.verfyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom);
        make.left.equalTo(self.contentView).offset(CCHorMargin);
        make.right.equalTo(self.contentView).offset(-CCHorMargin);
    }];
    [self.pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.verfyTextField.mas_bottom);
        make.left.equalTo(self.contentView).offset(CCHorMargin);
        make.right.equalTo(self.contentView).offset(-CCHorMargin);
    }];
    [self.confirmPwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pwdTextField.mas_bottom);
        make.left.equalTo(self.contentView).offset(CCHorMargin);
        make.right.equalTo(self.contentView).offset(-CCHorMargin);
    }];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.confirmPwdTextField.mas_bottom).offset(CCPXToPoint(152));
        make.centerX.equalTo(self.contentView);
    }];
}

#pragma mark - action
- (void)onClickSMSButton:(UIButton *)button
{
    NSString *phone = self.mobileField.text;
    if ([phone isLegalPhoneNum])
    {
        [_manager getSMSCodeWithPhone:phone];
        [self startSMSTimer];
    }
    else
    {
        [self showToast:@"无效号码"];
    }
}

- (void)onClickConfirmButton:(UIButton *)button
{
    if (self.mobileField.text.length == 0)
    {
        [self showToast:@"请输入手机号码"];
        return;
    }

    if (self.verfyTextField.textField.text.length == 0)
    {
        [self showToast:@"请输入验证码"];
        return;
    }
    if (self.pwdTextField.textField.text.length==0 || self.confirmPwdTextField.textField.text.length==0)
    {
        [self showToast:@"请输入密码"];
        return;
    }
    if (![self.pwdTextField.textField.text isEqualToString:self.confirmPwdTextField.textField.text])
    {
        [self showToast:@"两次密码不一致"];
        return;
    }
    if (![self.pwdTextField.textField.text isLegalPassword])
    {
        [self showToast:@"密码不符合规则"];
        return;
    }
    
    [self beginLoading];
    [_manager startRegisterWithPhone:self.mobileField.text password:self.pwdTextField.textField.text smsCode:self.verfyTextField.textField.text];
}

- (void)startSMSTimer
{
    [self stopSMSTimer];
    _smsTimer = [NSTimer timerWithTimeInterval:1.f target:self selector:@selector(onSMSTimer) userInfo:nil repeats:YES];
}

- (void)stopSMSTimer
{
    if (_smsTimer)
    {
        [_smsTimer invalidate];
        _smsTimer = nil;
        [self.getSMSCodeButton setEnabled:YES];
        [self.getSMSCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
}

- (void)onSMSTimer
{
    _fireCount += 1;
    if (_fireCount > 60)
    {
        [self stopSMSTimer];
    }
    else
    {
        [self.getSMSCodeButton setEnabled:NO];
        [self.getSMSCodeButton setTitle:[NSString stringWithFormat:@"%d", 60-_fireCount] forState:UIControlStateNormal];
    }
}

#pragma mark - CCRegisterDelegate
- (void)onGetSMSCodeSuccess:(NSDictionary *)dict
{
    
}

- (void)onGetSMSCodeFailed:(NSInteger)error errorMsg:(NSString *)msg
{
    [self showToast:msg];
    [self stopSMSTimer];
}

- (void)onRegisterSuccess:(NSDictionary *)dict
{
    [self endLoading];
    CCModifyUserInfoViewController *vc = [[CCModifyUserInfoViewController alloc] initWithType:MODIFYTYPE_REGISTER];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)onRegisterFailed:(NSInteger)error errorMsg:(NSString *)msg
{
    [self endLoading];
    [self showToast:msg];
}

#pragma mark - getters
- (UIView *)devideView
{
    if (!_devideView)
    {
        _devideView = [UIView new];
        [_devideView setBackgroundColor:BgColor_Clear];
    }
    return _devideView;
}

- (CCTextField *)mobileField
{
    if (!_mobileField)
    {
        _mobileField = [[CCTextField alloc] init];
        [_mobileField setLimitText:20];
        [_mobileField setFont:Font_Large];
        [_mobileField setTextColor:FontColor_Black];
        [_mobileField setKeyboardType:UIKeyboardTypeNumberPad];
        [_mobileField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:@{NSForegroundColorAttributeName:FontColor_Black}]];
    }
    return _mobileField;
}

- (UIButton *)getSMSCodeButton
{
    if (!_getSMSCodeButton)
    {
        _getSMSCodeButton = [UIButton new];
        [_getSMSCodeButton.layer setCornerRadius:3];
        [_getSMSCodeButton setBackgroundColor:BgColor_Yellow];
        [_getSMSCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getSMSCodeButton.titleLabel setFont:Font_Big];
        [_getSMSCodeButton.titleLabel setTextColor:FontColor_White];
        [_getSMSCodeButton addTarget:self action:@selector(onClickSMSButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getSMSCodeButton;
}

- (UIView *)lineView
{
    if (!_lineView)
    {
        _lineView = [UIView new];
        [_lineView setBackgroundColor:BgColor_LightGray];
    }
    return _lineView;
}

- (CCBigTextFieldView *)verfyTextField
{
    if (!_verfyTextField)
    {
        _verfyTextField = [CCBigTextFieldView new];
        [_verfyTextField.textField setKeyboardType:UIKeyboardTypeNumberPad];
        [_verfyTextField.textField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"请输入验证码" attributes:@{NSForegroundColorAttributeName:FontColor_Black}]];
    }
    return _verfyTextField;
}

- (CCBigTextFieldView *)pwdTextField
{
    if (!_pwdTextField)
    {
        _pwdTextField = [CCBigTextFieldView new];
        [_pwdTextField.textField setLimitText:20];
        [_pwdTextField.textField setSecureTextEntry:YES];
        [_pwdTextField.textField setKeyboardType:UIKeyboardTypeASCIICapableNumberPad];
        [_pwdTextField.textField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"密码（6-20位）" attributes:@{NSForegroundColorAttributeName:FontColor_Black}]];
    }
    return _pwdTextField;
}

- (CCBigTextFieldView *)confirmPwdTextField
{
    if (!_confirmPwdTextField)
    {
        _confirmPwdTextField = [CCBigTextFieldView new];
        [_confirmPwdTextField.textField setLimitText:20];
        [_confirmPwdTextField.textField setSecureTextEntry:YES];
        [_confirmPwdTextField.textField setKeyboardType:UIKeyboardTypeASCIICapableNumberPad];
        [_confirmPwdTextField.textField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"确认密码" attributes:@{NSForegroundColorAttributeName:FontColor_Black}]];
    }
    return _confirmPwdTextField;
}

- (CCBigButton *)confirmButton
{
    if (!_confirmButton)
    {
        _confirmButton = [CCBigButton new];
        [_confirmButton setTitle:[self getButtonTitle] forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(onClickConfirmButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

- (NSString *)getTitle
{
    if (self.type == REGISTERTYPE_REGISTER)
    {
        return @"注册";
    }
    else if (self.type == REGISTERTYPE_RESETPWD)
    {
        return @"找回密码";
    }
    return nil;
}

- (NSString *)getButtonTitle
{
    if (self.type == REGISTERTYPE_REGISTER)
    {
        return @"完成注册";
    }
    else if (self.type == REGISTERTYPE_RESETPWD)
    {
        return @"立即修改";
    }
    return nil;
}

@end
