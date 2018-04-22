//
//  CCGainMoneyViewController.m
//  esportking
//
//  Created by CKQ on 2018/4/15.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCGainMoneyViewController.h"
#import "CCCommitButton.h"
#import <CYPasswordView/CYPasswordView.h>
#import <TKAlert&TKActionSheet/TKAlert&TKActionSheet.h>
#import "NSString+MD5.h"
#import "CCGainMoneyRequest.h"

@interface CCGainMoneyViewController ()<CCRequestDelegate>

@property (assign, nonatomic) CGFloat totalMoney;
@property (strong, nonatomic) CCGainMoneyRequest *request;

@property (strong, nonatomic) UIView *keyboardBGView;
@property (strong, nonatomic) CYPasswordView *passView;

@property (strong, nonatomic) UILabel *topLabel;
@property (strong, nonatomic) UIView *accountBGView;
@property (strong, nonatomic) UITextField *accountField;
@property (strong, nonatomic) UILabel *tipsLabel;
@property (strong, nonatomic) UIView *centerView;
@property (strong, nonatomic) UILabel *moneyLabel;
@property (strong, nonatomic) UITextField *moneyField;
@property (strong, nonatomic) UIView *lineView;
@property (strong, nonatomic) UILabel *bottomLabel;
@property (strong, nonatomic) CCCommitButton *commitButton;

@end

@implementation CCGainMoneyViewController

- (instancetype)initWithMoney:(CGFloat)totalMoney
{
    if (self = [super init])
    {
        self.totalMoney = totalMoney;
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configTopbar];
    [self configContent];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)configTopbar
{
    [self addTopPopBackButton];
    [self addTopbarTitle:@"提现"];
}

- (void)configContent
{
    [self setContentWithTopOffset:LMStatusBarHeight+LMTopBarHeight bottomOffset:LMLayoutAreaBottomHeight];
    [self.contentView setBackgroundColor:BgColor_SuperLightGray];
    
    [self.contentView addSubview:self.topLabel];
    [self.contentView addSubview:self.accountBGView];
    [self.contentView addSubview:self.accountField];
    [self.contentView addSubview:self.tipsLabel];
    [self.contentView addSubview:self.centerView];
    [self.contentView addSubview:self.commitButton];
    
    [self.centerView addSubview:self.moneyLabel];
    [self.centerView addSubview:self.moneyField];
    [self.centerView addSubview:self.lineView];
    [self.centerView addSubview:self.bottomLabel];
    
    [self.contentView addSubview:self.keyboardBGView];
    
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(CCPXToPoint(40));
        make.left.equalTo(self.contentView).offset(CCHorMargin);
    }];
    [self.accountBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topLabel.mas_bottom).offset(CCPXToPoint(20));
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(CCPXToPoint(96));
    }];
    [self.accountField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.accountBGView);
        make.left.equalTo(self.accountBGView).offset(CCHorMargin);
        make.right.equalTo(self.accountBGView).offset(-CCHorMargin);
    }];
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.accountField.mas_bottom).offset(CCPXToPoint(40));
        make.left.equalTo(self.topLabel);
    }];
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tipsLabel.mas_bottom).offset(CCPXToPoint(20));
        make.left.right.bottom.equalTo(self.contentView);
    }];
    [self.commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(CCPXToPoint(96));
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.centerView).offset(CCHorMargin);
        make.top.equalTo(self.centerView).offset(CCPXToPoint(20));
    }];
    [self.moneyField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.moneyLabel);
        make.left.equalTo(self.moneyLabel).offset(CCPXToPoint(40));
        make.right.equalTo(self.centerView).offset(-CCHorMargin);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.moneyLabel.mas_bottom).offset(CCPXToPoint(20));
        make.left.right.equalTo(self.centerView);
        make.height.mas_equalTo(CCOnePoint);
    }];
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom);
        make.left.equalTo(self.centerView).offset(CCHorMargin);
        make.right.equalTo(self.centerView).offset(-CCHorMargin);
    }];
    
    [self.keyboardBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    [self.keyboardBGView setHidden:YES];
}

#pragma mark - Action
- (void)onClickCommitButton:(id)sender
{
    CCWeakSelf(weakSelf);
    TKAlertViewController *vc = [TKAlertViewController alertWithTitle:@"" message:[NSString stringWithFormat:@"确认提现%.2f元到支付宝账户（%@）中吗？", [self.moneyField.text floatValue], self.accountField.text]];
    [vc addCancelButtonWithTitle:@"取消" block:^(NSUInteger index) {
        
    }];
    [vc addButtonWithTitle:@"确定" block:^(NSUInteger index) {
        [weakSelf showPayPassView];
    }];
    [vc show];
}

- (void)showPayPassView
{
    CCWeakSelf(weakSelf);
    self.passView = [self createPassView];
    self.passView.finish = ^(NSString *password) {
        [weakSelf requestForGainMoney:password];
    };
    [self.passView showInView:self.view.window];
}

- (void)requestForGainMoney:(NSString *)paypass
{
    if (self.request)
    {
        return;
    }
    
    self.request = [[CCGainMoneyRequest alloc] init];
    self.request.account = self.accountField.text;
    self.request.amount = self.moneyField.text;
    self.request.payPass = [paypass md5Str];
    [self.request startPostRequestWithDelegate:self];
}

- (void)onTapKeyboardBGView:(id)sender
{
    [self.accountField resignFirstResponder];
    [self.moneyField resignFirstResponder];
}

#pragma mark - NSNotification
//当键盘出现
- (void)keyboardWillShow:(NSNotification *)notification
{
    [self.keyboardBGView setHidden:NO];
}

//当键退出
- (void)keyboardWillHide:(NSNotification *)notification
{
    [self.keyboardBGView setHidden:YES];
}

#pragma mark - CCRequestDelegate
- (void)onRequestSuccess:(NSDictionary *)dict sender:(id)sender
{
    if (sender != self.request)
    {
        return;
    }
    [self showToast:@"您的申请已提交，我们会尽快为您处理"];
    [self.passView stopLoading];
    [self.passView hide];
    [self.navigationController popViewControllerAnimated:YES];
    self.request = nil;
}

- (void)onRequestFailed:(NSInteger)errorCode errorMsg:(NSString *)msg sender:(id)sender
{
    if (sender != self.request)
    {
        return;
    }
    [self.passView stopLoading];
    [self.passView hide];
    [self showToast:msg];
    self.request = nil;
}

#pragma mark - getter
- (UILabel *)topLabel
{
    if (!_topLabel)
    {
        _topLabel = [UILabel createOneLineLabelWithFont:Font_Big color:FontColor_LightDark];
        [_topLabel setText:@"请输入提现支付宝账号"];
    }
    return _topLabel;
}

- (UIView *)accountBGView
{
    if (!_accountBGView)
    {
        _accountBGView = [UIView new];
        [_accountBGView setBackgroundColor:BgColor_White];
    }
    return _accountBGView;
}

- (UITextField *)accountField
{
    if (!_accountField)
    {
        _accountField = [UITextField new];
        [_accountField setBackgroundColor:BgColor_White];
        [_accountField setFont:Font_Large];
        [_accountField setTextColor:FontColor_Black];
        [_accountField setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"支付宝邮箱或手机号" attributes:@{NSForegroundColorAttributeName:FontColor_LightDark}]];
    }
    return _accountField;
}

- (UILabel *)tipsLabel
{
    if (!_tipsLabel)
    {
        _tipsLabel = [UILabel createOneLineLabelWithFont:Font_Big color:FontColor_LightDark];
        [_tipsLabel setText:@"请输入提现金额"];
    }
    return _tipsLabel;
}

- (UIView *)centerView
{
    if (!_centerView)
    {
        _centerView = [UIView new];
        [_centerView setBackgroundColor:BgColor_White];
    }
    return _centerView;
}

- (UILabel *)moneyLabel
{
    if (!_moneyLabel)
    {
        _moneyLabel = [UILabel createOneLineLabelWithFont:BoldFont_Great color:FontColor_Black];
        [_moneyLabel setText:@"¥"];
    }
    return _moneyLabel;
}

- (UITextField *)moneyField
{
    if (!_moneyField)
    {
        _moneyField = [UITextField new];
        [_moneyField setKeyboardType:UIKeyboardTypeNumberPad];
        [_moneyField setFont:BoldFont_Great];
    }
    return _moneyField;
}

- (UIView *)lineView
{
    if (!_lineView)
    {
        _lineView = [UIView new];
        [_lineView setBackgroundColor:BgColor_SuperLightGray];
    }
    return _lineView;
}

- (UILabel *)bottomLabel
{
    if (!_bottomLabel)
    {
        _bottomLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_LightDark];
        [_bottomLabel setTextAlignment:NSTextAlignmentLeft];
        [_bottomLabel setText:[NSString stringWithFormat:@"可用余额%.2f元", self.totalMoney]];
    }
    return _bottomLabel;
}

- (CCCommitButton *)commitButton
{
    if (!_commitButton)
    {
        _commitButton = [CCCommitButton new];
        [_commitButton setTitle:@"确认提现" forState:UIControlStateNormal];
        [_commitButton addTarget:self action:@selector(onClickCommitButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commitButton;
}

- (UIView *)keyboardBGView
{
    if (!_keyboardBGView)
    {
        _keyboardBGView = [UIView new];
        [_keyboardBGView setBackgroundColor:BgColor_Clear];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(onTapKeyboardBGView:)];
        [_keyboardBGView addGestureRecognizer:gesture];
    }
    return _keyboardBGView;
}

- (CYPasswordView *)createPassView
{
    CYPasswordView *passView = [CYPasswordView new];
    passView.title =@"输入支付密码";
    passView.loadingText = @"提交中……";
    return passView;
}

@end
