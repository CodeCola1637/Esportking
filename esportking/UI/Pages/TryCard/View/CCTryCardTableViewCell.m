//
//  CCTryCardTableViewCell.m
//  esportking
//
//  Created by jaycechen on 2018/2/28.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCTryCardTableViewCell.h"

@interface CCTryCardTableViewCell ()

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *numLabel;
@property (strong, nonatomic) UILabel *statusLabel;
@property (strong, nonatomic) UILabel *descLabel;

@end

@implementation CCTryCardTableViewCell

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
    [self.contentView.layer setCornerRadius:CCPXToPoint(10)];
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.numLabel];
    [self.contentView addSubview:self.statusLabel];
    [self.contentView addSubview:self.descLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(CCPXToPoint(32));
        make.top.equalTo(self.contentView).offset(CCPXToPoint(32));
    }];
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(CCPXToPoint(12));
    }];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.numLabel);
        make.right.equalTo(self.contentView).offset(-CCPXToPoint(32));
    }];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.numLabel.mas_bottom).offset(CCPXToPoint(24));
    }];
}

- (void)setTryCardDict:(NSDictionary *)dict
{
    
}

#pragma mark - getter
- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [UILabel createOneLineLabelWithFont:Font_Big color:FontColor_White];
    }
    return _titleLabel;
}

- (UILabel *)numLabel
{
    if (!_numLabel)
    {
        _numLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_White];
    }
    return _numLabel;
}

- (UILabel *)statusLabel
{
    if (!_statusLabel)
    {
        _statusLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_White];
    }
    return _statusLabel;
}

- (UILabel *)descLabel
{
    if (!_descLabel)
    {
        _descLabel = [UILabel createOneLineLabelWithFont:Font_Small color:FontColor_White];
    }
    return _descLabel;
}

@end
