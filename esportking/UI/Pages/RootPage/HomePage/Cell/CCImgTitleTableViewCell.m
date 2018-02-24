//
//  CCImgTitleTableViewCell.m
//  esportking
//
//  Created by CKQ on 2018/2/17.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCImgTitleTableViewCell.h"

@implementation CCImgTitleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setupUI];
    }
    return self;
}

- (void)setIcon:(UIImage *)icon andTitle:(NSString *)title
{
    [self.iconView setImage:icon];
    [self.titleLabel setText:title];
}

- (void)setupUI
{
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.subTitleLabel];
    [self.contentView addSubview:self.arrowImgView];
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(CCPXToPoint(32));
        make.size.mas_equalTo(CGSizeMake(CCPXToPoint(52), CCPXToPoint(52)));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.iconView.mas_right).offset(CCPXToPoint(20));
    }];
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.arrowImgView.mas_left).offset(-CCPXToPoint(26));
    }];
    [self.arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self).offset(-CCPXToPoint(32));
    }];
}

#pragma mark - getters
- (UIImageView *)iconView
{
    if (!_iconView)
    {
        _iconView = [UIImageView new];
        [_iconView setContentMode:UIViewContentModeScaleAspectFill];
    }
    return _iconView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [UILabel createOneLineLabelWithFont:Font_Big color:FontColor_Black];
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel
{
    if (!_subTitleLabel)
    {
        _subTitleLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_Gray];
    }
    return _subTitleLabel;
}

- (UIImageView *)arrowImgView
{
    if (!_arrowImgView)
    {
        _arrowImgView = [[UIImageView alloc] initWithImage:CCIMG(@"Right_Arrow")];
        [_arrowImgView setContentMode:UIViewContentModeScaleAspectFit];
    }
    return _arrowImgView;
}

@end
