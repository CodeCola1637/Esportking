//
//  CCDevideTableViewCell.m
//  esportking
//
//  Created by jaycechen on 2018/3/2.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCDevideTableViewCell.h"

@interface CCDevideTableViewCell ()

@property (strong, nonatomic) UILabel *label;

@end

@implementation CCDevideTableViewCell

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
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self.contentView addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(CCPXToPoint(32));
        make.right.equalTo(self.contentView).offset(-CCPXToPoint(32));
    }];
}

- (void)setContentText:(NSString *)text
{
    [self.label setText:text];
}

- (UILabel *)label
{
    if (!_label)
    {
        _label = [UILabel createMultiLineLabelWithFont:Font_Middle color:FontColor_DeepDark];
        [_label setTextAlignment:NSTextAlignmentLeft];
    }
    return _label;
}

@end
