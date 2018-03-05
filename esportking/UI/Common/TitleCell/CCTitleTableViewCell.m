//
//  CCTitleTableViewCell.m
//  esportking
//
//  Created by jaycechen on 2018/3/2.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCTitleTableViewCell.h"

@interface CCTitleTableViewCell ()

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *subTitleLabel;
@property (strong, nonatomic) UIImageView *arrowImgView;

@end

@implementation CCTitleTableViewCell

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
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.subTitleLabel];
    [self.contentView addSubview:self.arrowImgView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(CCPXToPoint(32));
    }];
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.arrowImgView.mas_left).offset(-CCPXToPoint(26));
    }];
    [self.arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-CCPXToPoint(32));;
    }];
}

- (void)setTitle:(NSString *)title subTitle:(NSString *)subTitle subTitleColor:(UIColor *)color
{
    [self.titleLabel setText:title];
    [self changeSubTitle:subTitle subTitleColor:color];
}

- (void)changeSubTitle:(NSString *)subTitle subTitleColor:(UIColor *)color
{
    [self.subTitleLabel setText:subTitle];
    [self.subTitleLabel setTextColor:color];
}

- (void)enableArrow:(BOOL)enable
{
    [self.arrowImgView setHidden:!enable];
}

#pragma mark - getters
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
        _subTitleLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_LightGray];
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
