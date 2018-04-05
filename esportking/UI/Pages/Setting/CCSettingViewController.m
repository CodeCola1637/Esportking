//
//  CCSettingViewController.m
//  esportking
//
//  Created by CKQ on 2018/3/13.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCSettingViewController.h"
#import "CCAccountViewController.h"
#import "CCBlackListViewController.h"
#import "CCHelpWebViewController.h"

#import "AppDelegate.h"

#import "CCAccountService.h"
#import "CCTitleItem.h"

@interface CCSettingViewController ()<CCTitleItemDelegate>

@property (strong, nonatomic) CCTitleItem *accountItem;
@property (strong, nonatomic) CCTitleItem *messageItem;
@property (strong, nonatomic) CCTitleItem *blackUserItem;
@property (strong, nonatomic) CCTitleItem *helpItem;
@property (strong, nonatomic) CCTitleItem *aboutItem;

@property (strong, nonatomic) UIButton *logoutButton;

@end

@implementation CCSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configTopbar];
    [self configContent];
}

- (void)configTopbar
{
    [self addTopPopBackButton];
    [self addTopbarTitle:@"设置"];
}

- (void)configContent
{
    [self setContentWithTopOffset:LMStatusBarHeight+LMTopBarHeight bottomOffset:LMLayoutAreaBottomHeight];
    
    [self.contentView addSubview:self.accountItem];
    [self.contentView addSubview:self.messageItem];
    [self.contentView addSubview:self.blackUserItem];
    [self.contentView addSubview:self.helpItem];
    [self.contentView addSubview:self.aboutItem];
    [self.contentView addSubview:self.logoutButton];
    
    [self.accountItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(CCPXToPoint(0));
        make.right.equalTo(self.contentView).offset(-CCPXToPoint(0));
        make.top.equalTo(self.contentView);
    }];
    [self.messageItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.accountItem);
        make.top.equalTo(self.accountItem.mas_bottom);
    }];
    [self.blackUserItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.accountItem);
        make.top.equalTo(self.messageItem.mas_bottom);
    }];
    [self.helpItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.accountItem);
        make.top.equalTo(self.blackUserItem.mas_bottom);
    }];
    [self.aboutItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.accountItem);
        make.top.equalTo(self.helpItem.mas_bottom);
    }];
    [self.logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.height.mas_equalTo(CCPXToPoint(120));
    }];
}

#pragma mark - action
- (void)onClickLogoutButton:(UIButton *)button
{
    [CCAccountServiceInstance saveLoginDict:nil];
    [((AppDelegate *)[UIApplication sharedApplication].delegate) changeToLoginPage];
}

#pragma mark - CCTitleItemDelegate
- (void)onClickTitleItem:(id)sender
{
    if (sender == self.accountItem)
    {
        CCAccountViewController *vc = [CCAccountViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (sender == self.messageItem)
    {
        
    }
    else if (sender == self.blackUserItem)
    {
        CCBlackListViewController *vc = [CCBlackListViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (sender == self.helpItem)
    {
        CCHelpWebViewController *vc = [CCHelpWebViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (sender == self.aboutItem)
    {
        
    }
}

#pragma mark - getter
- (CCTitleItem *)accountItem
{
    if (!_accountItem)
    {
        _accountItem = [[CCTitleItem alloc] initWithTitle:@"账户与安全" subTitle:nil subTitleColor:nil delegate:self];
    }
    return _accountItem;
}

- (CCTitleItem *)messageItem
{
    if (!_messageItem)
    {
        _messageItem = [[CCTitleItem alloc] initWithTitle:@"消息设置" subTitle:nil subTitleColor:nil delegate:self];
    }
    return _messageItem;
}

- (CCTitleItem *)blackUserItem
{
    if (!_blackUserItem)
    {
        _blackUserItem = [[CCTitleItem alloc] initWithTitle:@"黑名单" subTitle:nil subTitleColor:nil delegate:self];
    }
    return _blackUserItem;
}

- (CCTitleItem *)helpItem
{
    if (!_helpItem)
    {
        _helpItem = [[CCTitleItem alloc] initWithTitle:@"帮助" subTitle:nil subTitleColor:nil delegate:self];
    }
    return _helpItem;
}

- (CCTitleItem *)aboutItem
{
    if (!_aboutItem)
    {
        _aboutItem = [[CCTitleItem alloc] initWithTitle:@"关于我们" subTitle:nil subTitleColor:nil delegate:self];
    }
    return _aboutItem;
}

- (UIButton *)logoutButton
{
    if (!_logoutButton)
    {
        _logoutButton = [UIButton new];
        [_logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
        [_logoutButton setTitleColor:FontColor_Black forState:UIControlStateNormal];
        [_logoutButton addTarget:self action:@selector(onClickLogoutButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logoutButton;
}

@end
