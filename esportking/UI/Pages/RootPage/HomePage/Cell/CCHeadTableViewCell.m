//
//  CCHeadTableViewCell.m
//  esportking
//
//  Created by CKQ on 2018/2/17.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCHeadTableViewCell.h"

@interface CCHeadTableViewCell ()

@property (strong, nonatomic) UIImageView *headImgView;
@property (strong, nonatomic) UILabel *nickLabel;

@end

@implementation CCHeadTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setupUI];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onUserInfoChangeNotification:) name:CCInfoChangeNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupUI
{
    UIView *centerView = [UIView new];
    [self.contentView addSubview:centerView];
    [self.contentView addSubview:self.headImgView];
    [self.contentView addSubview:self.nickLabel];
    
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
    }];
    [self.headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(centerView);
        make.centerX.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(CCPXToPoint(140), CCPXToPoint(140)));
    }];
    [self.nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImgView.mas_bottom).offset(CCPXToPoint(24));
        make.bottom.equalTo(centerView);
        make.centerX.equalTo(centerView);
    }];
}

#pragma mark - CCInfoChangeNotification
- (void)onUserInfoChangeNotification:(NSNotification *)notify
{
    [_headImgView setImageWithUrl:CCAccountServiceInstance.headUrl placeholder:_headImgView.image];
    [_nickLabel setText:CCAccountServiceInstance.name];
}

#pragma mark - getters
- (UIImageView *)headImgView
{
    if (!_headImgView)
    {
        _headImgView = [UIImageView scaleFillImageView];
        [_headImgView.layer setCornerRadius:CCPXToPoint(70)];
        [_headImgView setImageWithUrl:CCAccountServiceInstance.headUrl placeholder:CCIMG(@"Default_Header")];
    }
    return _headImgView;
}

- (UILabel *)nickLabel
{
    if (!_nickLabel)
    {
        _nickLabel = [UILabel createOneLineLabelWithFont:BoldFont_Big color:FontColor_Black];
        [_nickLabel setText:CCAccountServiceInstance.name];
    }
    return _nickLabel;
}

@end
