//
//  CCAboutViewController.m
//  esportking
//
//  Created by CKQ on 2018/4/5.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCAboutViewController.h"

@interface CCAboutViewController ()

@property (strong, nonatomic) UIImageView *iconImgView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *locationLabel;
@property (strong, nonatomic) UIView *bottomView;
@property (strong, nonatomic) UILabel *smsTipLabel;
@property (strong, nonatomic) UILabel *smsLabel;

@end

@implementation CCAboutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configTopbar];
    [self configContent];
}

- (void)configTopbar
{
    [self addTopbarTitle:@"关于我们"];
    [self addTopPopBackButton];
}

- (void)configContent
{
    [self setContentWithTopOffset:LMStatusBarHeight+LMTopBarHeight bottomOffset:LMLayoutAreaBottomHeight];
    
    [self.contentView addSubview:self.iconImgView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.locationLabel];
    [self.contentView addSubview:self.bottomView];
    [self.bottomView addSubview:self.smsTipLabel];
    [self.bottomView addSubview:self.smsLabel];
    
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(CCPXToPoint(352)-LMStatusBarHeight-LMTopBarHeight);
        make.centerX.equalTo(self.contentView);
        make.width.height.mas_equalTo(CCPXToPoint(160));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImgView.mas_bottom).offset(CCPXToPoint(32));
        make.centerX.equalTo(self.contentView);
    }];
    [self.locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(self.bottomView.mas_top).offset(-CCPXToPoint(4));
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-CCPXToPoint(104));
    }];
    [self.smsTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.bottomView);
    }];
    [self.smsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self.bottomView);
        make.left.equalTo(self.smsTipLabel.mas_right);
    }];
}

#pragma mark - action
- (void)onClickSmsLabel:(id)sender
{
    NSString *callPhone = @"telprompt://0755-86716634";
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
    }
}

#pragma mark - getters
- (UIImageView *)iconImgView
{
    if (!_iconImgView)
    {
        _iconImgView = [UIImageView scaleFillImageView];
        [_iconImgView.layer setCornerRadius:CCPXToPoint(28)];
        NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
        NSArray *iconsArr = infoDict[@"CFBundleIcons"][@"CFBundlePrimaryIcon"][@"CFBundleIconFiles"];
        NSString *iconLastName = [iconsArr lastObject];
        [_iconImgView setImage:CCIMG(iconLastName)];
    }
    return _iconImgView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_Black];
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        [_titleLabel setText:[NSString stringWithFormat:@"%@ %@", app_Name, app_Version]];
    }
    return _titleLabel;
}

- (UILabel *)locationLabel
{
    if (!_locationLabel)
    {
        _locationLabel = [UILabel createOneLineLabelWithFont:Font_Small color:FontColor_Black];
        [_locationLabel setText:@"深圳市深游网络科技有限公司"];
    }
    return _locationLabel;
}

- (UIView *)bottomView
{
    if (!_bottomView)
    {
        _bottomView = [UIView new];
    }
    return _bottomView;
}

- (UILabel *)smsTipLabel
{
    if (!_smsTipLabel)
    {
        _smsTipLabel = [UILabel createOneLineLabelWithFont:Font_Small color:FontColor_Black];
        [_smsTipLabel setText:@"客服联系电话："];
    }
    return _smsTipLabel;
}

- (UILabel *)smsLabel
{
    if (!_smsLabel)
    {
        _smsLabel = [UILabel createOneLineLabelWithFont:Font_Small color:FontColor_Gold];
        [_smsLabel setText:@"0755-86716634"];
        [_smsLabel setUserInteractionEnabled:YES];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickSmsLabel:)];
        [_smsLabel addGestureRecognizer:gesture];
    }
    return _smsLabel;
}

@end
