//
//  CCOrderTableViewCell.m
//  esportking
//
//  Created by jaycechen on 2018/3/2.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCConfirmTableViewCell.h"

@interface CCConfirmTableViewCell ()

@property (weak  , nonatomic) id<CCConfirmTableViewCellDelegate> delegate;
@property (strong, nonatomic) UILabel *priceLabel;
@property (strong, nonatomic) UIButton *orderButton;

@end

@implementation CCConfirmTableViewCell

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
    
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.orderButton];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.equalTo(self.contentView);
        make.width.equalTo(self.contentView).multipliedBy(.5f);
    }];
    [self.orderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self.contentView);
        make.width.equalTo(self.contentView).multipliedBy(.5f);
    }];
}

- (void)setPrice:(uint64_t)price andDelegate:(id<CCConfirmTableViewCellDelegate>)del
{
    self.delegate = del;
    [self.priceLabel setText:[NSString stringWithFormat:@"¥%ld元", price]];
}

#pragma mark - action
- (void)onClickOrderButton:(UIButton *)button
{
    [self.delegate onSelectOrder];
}

#pragma mark - getter
- (UILabel *)priceLabel
{
    if (!_priceLabel)
    {
        _priceLabel = [UILabel createMultiLineLabelWithFont:Font_Big color:FontColor_Red];
    }
    return _priceLabel;
}

- (UIButton *)orderButton
{
    if (!_orderButton)
    {
        _orderButton = [UIButton new];
        [_orderButton setBackgroundColor:BgColor_Yellow];
        [_orderButton setTitle:@"下单" forState:UIControlStateNormal];
        [_orderButton setTitleColor:FontColor_Black forState:UIControlStateNormal];
        [_orderButton addTarget:self action:@selector(onClickOrderButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _orderButton;
}

@end
