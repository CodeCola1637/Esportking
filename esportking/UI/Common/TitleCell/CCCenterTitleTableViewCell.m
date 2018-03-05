//
//  CCCenterTItleTableViewCell.m
//  esportking
//
//  Created by jaycechen on 2018/3/5.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCCenterTitleTableViewCell.h"

@interface CCCenterTitleTableViewCell ()

@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation CCCenterTitleTableViewCell

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
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
}

- (void)setTitle:(NSString *)title
{
    [self.titleLabel setText:title];
}

#pragma mark - getter
- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_Gray];
    }
    return _titleLabel;
}

@end
