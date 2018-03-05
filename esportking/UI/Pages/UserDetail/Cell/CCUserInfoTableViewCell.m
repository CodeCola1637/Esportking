//
//  CCUserInfoTableViewCell.m
//  esportking
//
//  Created by CKQ on 2018/2/25.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCUserInfoTableViewCell.h"
#import "CCGenderOldView.h"

@interface CCUserInfoTableViewCell()

@property (strong, nonatomic) CCGameModel *logicModel;

@property (strong, nonatomic) UIImageView *headImgView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) CCGenderOldView *genderView;
@property (strong, nonatomic) UIButton *followButton;
@property (strong, nonatomic) UIImageView *locationImgView;
@property (strong, nonatomic) UILabel *locationLabel;
@property (strong, nonatomic) UILabel *hornorLabel;

@end

@implementation CCUserInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    [self setBackgroundColor:BgColor_White];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [self.contentView addSubview:self.headImgView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.genderView];
    [self.contentView addSubview:self.followButton];
    [self.contentView addSubview:self.locationImgView];
    [self.contentView addSubview:self.locationLabel];
    [self.contentView addSubview:self.hornorLabel];
    
    [self.headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(CCPXToPoint(696));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(CCPXToPoint(36));
        make.top.equalTo(self.headImgView.mas_bottom).offset(CCPXToPoint(36));
    }];
    [self.genderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset(CCPXToPoint(20));
        make.centerY.equalTo(self.nameLabel);
        make.height.mas_equalTo(CCPXToPoint(30));
    }];
    [self.followButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.nameLabel);
        make.right.equalTo(self.contentView).offset(-CCPXToPoint(36));
        make.width.mas_equalTo(CCPXToPoint(152));
        make.height.mas_equalTo(CCPXToPoint(58));
    }];
    [self.locationImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(CCPXToPoint(20));
        make.left.equalTo(self.nameLabel);
        make.width.height.mas_equalTo(CCPXToPoint(24));
    }];
    [self.locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.locationImgView).offset(CCOnePoint);
        make.bottom.equalTo(self.locationImgView);
    }];
    [self.hornorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.locationLabel);
        make.top.equalTo(self.locationLabel.mas_bottom).offset(CCPXToPoint(20));
    }];
}

- (void)setGameModel:(CCGameModel *)model
{
    self.logicModel = model;
    
    [self.headImgView setImageWithUrl:model.userModel.headUrl placeholder:CCIMG(@"Default_Header")];
    [self.nameLabel setText:model.userModel.name];
    [self.genderView setGender:model.userModel.gender andOld:model.userModel.age];
    [self.locationLabel setText:model.serverName];
    [self.hornorLabel setText:model.maxLevel];
}

#pragma mark - action
- (void)onClickFollowButton:(UIButton *)button
{
    
}

#pragma mark - getter
- (UIImageView *)headImgView
{
    if (!_headImgView)
    {
        _headImgView = [UIImageView new];
        [_headImgView setContentMode:UIViewContentModeScaleAspectFill];
        [_headImgView setClipsToBounds:YES];
    }
    return _headImgView;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel)
    {
        _nameLabel = [UILabel createOneLineLabelWithFont:BoldFont_Great color:FontColor_Black];
    }
    return _nameLabel;
}

- (CCGenderOldView *)genderView
{
    if (!_genderView)
    {
        _genderView = [[CCGenderOldView alloc] init];
        [_genderView.layer setCornerRadius:CCPXToPoint(15)];
    }
    return _genderView;
}

- (UIButton *)followButton
{
    if (!_followButton)
    {
        _followButton = [UIButton new];
        [_followButton.layer setCornerRadius:CCPXToPoint(29)];
        [_followButton setBackgroundColor:BgColor_Yellow];
        [_followButton setTitle:@"关注" forState:UIControlStateNormal];
        [_followButton setTitleColor:FontColor_Black forState:UIControlStateNormal];
    }
    return _followButton;
}

- (UIImageView *)locationImgView
{
    if (!_locationImgView)
    {
        _locationImgView = [UIImageView new];
        [_locationImgView setContentMode:UIViewContentModeScaleAspectFill];
        [_locationImgView setClipsToBounds:YES];
    }
    return _locationImgView;
}

- (UILabel *)locationLabel
{
    if (!_locationLabel)
    {
        _locationLabel = [UILabel createOneLineLabelWithFont:Font_Small color:FontColor_Gray];
    }
    return _locationLabel;
}

- (UILabel *)hornorLabel
{
    if (!_hornorLabel)
    {
        _hornorLabel = [UILabel createOneLineLabelWithFont:Font_Small color:FontColor_Gray];
    }
    return _hornorLabel;
}

@end
