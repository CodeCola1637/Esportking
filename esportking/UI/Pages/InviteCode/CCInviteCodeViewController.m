//
//  CCInviteCodeViewController.m
//  esportking
//
//  Created by CKQ on 2018/3/13.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCInviteCodeViewController.h"
#import "CCAccountService.h"
#import "CCBindInviteCodeRequest.h"

#import <TKAlert&TKActionSheet/TKAlert&TKActionSheet.h>

@interface CCInviteCodeViewController ()<CCRequestDelegate>

@property (strong, nonatomic) CCBindInviteCodeRequest *request;

@property (strong ,nonatomic) UIImageView *bannerImgView;

@property (strong, nonatomic) UIView *textBGView;
@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) UIButton *bindButton;

@property (strong, nonatomic) UILabel *bindCodeLabel;

@property (strong, nonatomic) UILabel *descLabel;
@property (strong, nonatomic) UIButton *moreButton;

@end

@implementation CCInviteCodeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configTopbar];
    [self configContent];
    [self configData];
}

- (void)configTopbar
{
    [self addTopPopBackButton];
    [self addTopbarTitle:@"邀请码"];
}

- (void)configContent
{
    [self setContentWithTopOffset:LMStatusBarHeight+LMTopBarHeight bottomOffset:LMLayoutAreaBottomHeight];
    
    [self.contentView addSubview:self.bannerImgView];
    [self.contentView addSubview:self.textBGView];
    [self.contentView addSubview:self.bindButton];
    [self.contentView addSubview:self.descLabel];
    [self.contentView addSubview:self.bindCodeLabel];
    [self.contentView addSubview:self.moreButton];
    [self.textBGView addSubview:self.textField];
    
    [self.bannerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(CCPXToPoint(300));
    }];
    [self.textBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bannerImgView.mas_bottom).offset(CCPXToPoint(84));
        make.centerX.equalTo(self.contentView);
        make.width.mas_equalTo(CCPXToPoint(400));
        make.height.mas_equalTo(CCPXToPoint(80));
    }];
    [self.bindButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.textBGView);
        make.height.equalTo(self.textBGView);
        make.top.equalTo(self.textBGView.mas_bottom).offset(CCPXToPoint(48));
    }];
    [self.bindCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.bannerImgView.mas_bottom).offset(CCPXToPoint(168));
    }];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.bindButton.mas_bottom).offset(CCPXToPoint(48));
    }];
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(CCPXToPoint(96));
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.textBGView);
    }];
}

- (void)configData
{
    NSString *bindInviteCode = CCAccountServiceInstance.bindInviteCode;
    if (bindInviteCode && bindInviteCode.length>0)
    {
        [self.textBGView setHidden:YES];
        [self.bindButton setHidden:YES];
        [self.bindCodeLabel setHidden:NO];
        [self.bindCodeLabel setText:[NSString stringWithFormat:@"已绑定邀请码：%@", bindInviteCode]];
    }
    else
    {
        [self.bindCodeLabel setHidden:YES];
        [self.textBGView setHidden:NO];
        [self.bindButton setHidden:NO];
    }
}

#pragma mark - action
- (void)onClickBindButton:(UIButton *)button
{
    NSString *code = self.textField.text;
    if (code && code.length>0)
    {
        CCWeakSelf(weakSelf);
        TKAlertViewController *alert = [TKAlertViewController alertWithTitle:@"绑定邀请码" message:[NSString stringWithFormat:@"确定绑定邀请码【%@】吗？", code]];
        [alert addCancelButtonWithTitle:@"取消" block:nil];
        [alert addButtonWithTitle:@"确定" block:^(NSUInteger index) {
            [weakSelf doBindInviteCode:code];
        }];
        [alert show];
    }
}

- (void)onClickMoreButton:(UIButton *)button
{
    
}

- (void)doBindInviteCode:(NSString *)code
{
    self.request = [CCBindInviteCodeRequest new];
    self.request.inviteCode = code;
    [self.request startPostRequestWithDelegate:self];
    [self beginLoading];
}

#pragma mark -
- (void)onRequestSuccess:(NSDictionary *)dict sender:(id)sender
{
    if (self.request != sender)
    {
        return;
    }
    CCAccountServiceInstance.bindInviteCode = self.request.inviteCode;
    [self configData];
    [self endLoading];
    self.request = nil;
}

- (void)onRequestFailed:(NSInteger)errorCode errorMsg:(NSString *)msg sender:(id)sender
{
    [self endLoading];
    [self showToast:msg];
}

#pragma mark - getters
- (UIImageView *)bannerImgView
{
    if (!_bannerImgView)
    {
        _bannerImgView = [UIImageView scaleFillImageView];
        [_bannerImgView setImage:CCIMG(@"Score_Banner")];
    }
    return _bannerImgView;
}

- (UIView *)textBGView
{
    if (!_textBGView)
    {
        _textBGView = [UIView new];
        [_textBGView.layer setBorderColor:BgColor_Gold.CGColor];
        [_textBGView.layer setBorderWidth:CCOnePoint];
        [_textBGView.layer setCornerRadius:CCPXToPoint(6)];
    }
    return _textBGView;
}

- (UITextField *)textField
{
    if (!_textField)
    {
        _textField = [UITextField new];
        [_textField setFont:Font_Large];
        [_textField setTextColor:BgColor_Black];
        [_textField setPlaceholder:@"请输入邀请码"];
    }
    return _textField;
}

- (UIButton *)bindButton
{
    if (!_bindButton)
    {
        _bindButton = [UIButton new];
        [_bindButton setBackgroundColor:BgColor_Gold];
        [_bindButton setTitle:@"马上绑定" forState:UIControlStateNormal];
        [_bindButton setTitleColor:BgColor_Black forState:UIControlStateNormal];
        [_bindButton addTarget:self action:@selector(onClickBindButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bindButton;
}

- (UILabel *)bindCodeLabel
{
    if (!_bindCodeLabel)
    {
        _bindCodeLabel = [UILabel createOneLineLabelWithFont:Font_Large color:FontColor_Black];
    }
    return _bindCodeLabel;
}

- (UILabel *)descLabel
{
    if (!_descLabel)
    {
        _descLabel = [UILabel createMultiLineLabelWithFont:Font_Middle color:FontColor_Gray];
        [_descLabel setText:@"1.只能绑定一个ID，绑定后无法取消\n2.绑定成功后将获得一个5元红包\n3.你可以使用你的邀请码参与推广"];
    }
    return _descLabel;
}

- (UIButton *)moreButton
{
    if (!_moreButton)
    {
        _moreButton = [UIButton new];
        [_moreButton setBackgroundColor:BgColor_Yellow];
        [_moreButton setTitle:@"我也要推广" forState:UIControlStateNormal];
        [_moreButton setTitleColor:BgColor_Black forState:UIControlStateNormal];
        [_moreButton addTarget:self action:@selector(onClickMoreButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreButton;
}

@end
