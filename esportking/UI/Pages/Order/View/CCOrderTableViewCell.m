//
//  CCOrderTableViewCell.m
//  esportking
//
//  Created by jaycechen on 2018/2/28.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCOrderTableViewCell.h"

@interface CCOrderTableViewCell ()

@property (strong, nonatomic) NSDictionary *dataDict;
@property (weak, nonatomic) id<CCOrderTableViewCellDelegate> delegate;

@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UILabel *statusLabel;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *locationLabel;
@property (strong, nonatomic) UILabel *duanLabel;
@property (strong, nonatomic) UILabel *moneyLabel;
@property (strong, nonatomic) UIView *topLineView;
@property (strong, nonatomic) UIView *bottomLineView;
@property (strong, nonatomic) UIButton *cancelButton;
@property (strong, nonatomic) UIButton *confirmButton;
@property (strong, nonatomic) UIView *bottomView;

@end

@implementation CCOrderTableViewCell

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
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.statusLabel];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.locationLabel];
    [self.contentView addSubview:self.duanLabel];
    [self.contentView addSubview:self.moneyLabel];
    [self.contentView addSubview:self.topLineView];
    [self.contentView addSubview:self.bottomLineView];
    [self.contentView addSubview:self.bottomView];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(CCPXToPoint(32));
    }];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-CCPXToPoint(32));
        make.bottom.equalTo(self.timeLabel);
    }];
    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.timeLabel.mas_bottom).offset(CCPXToPoint(20));
        make.height.mas_equalTo(CCOnePoint);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeLabel);
        make.top.equalTo(self.topLineView.mas_bottom).offset(CCPXToPoint(20));
    }];
    [self.locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.nameLabel).offset(CCPXToPoint(6));
    }];
    [self.duanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.locationLabel);
        make.top.equalTo(self.locationLabel).offset(CCPXToPoint(6));
    }];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.duanLabel);
        make.top.equalTo(self.duanLabel).offset(CCPXToPoint(6));
    }];
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.topLineView);
        make.top.equalTo(self.moneyLabel).offset(CCPXToPoint(20));
        make.height.mas_equalTo(CCOnePoint);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(CCPXToPoint(40));
    }];
}

- (void)setOrderDict:(NSDictionary *)dict andDelegate:(id<CCOrderTableViewCellDelegate>)del
{
    self.dataDict = dict;
    self.delegate = del;
}

#pragma mark - action
- (void)onClickCancelButton:(UIButton *)button
{
    [self.delegate onCancelOrder:self.dataDict];
}

- (void)onClickConfirmButton:(UIButton *)button
{
    [self.delegate onConfirmOrder:self.dataDict];
}

#pragma mark - getters
- (UILabel *)timeLabel
{
    if (!_timeLabel)
    {
        _timeLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_Gray];
    }
    return _timeLabel;
}

- (UILabel *)statusLabel
{
    if (!_statusLabel)
    {
        _statusLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_Yellow];
    }
    return _statusLabel;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel)
    {
        _nameLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_Black];
    }
    return _nameLabel;
}

- (UILabel *)locationLabel
{
    if (!_locationLabel)
    {
        _locationLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_Black];
    }
    return _locationLabel;
}

- (UILabel *)duanLabel
{
    if (!_duanLabel)
    {
        _duanLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_Black];
    }
    return _duanLabel;
}

- (UILabel *)moneyLabel
{
    if (!_moneyLabel)
    {
        _moneyLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_Black];
    }
    return _moneyLabel;
}

- (UIView *)topLineView
{
    if (!_topLineView)
    {
        _topLineView = [UIView new];
        [_topLineView setBackgroundColor:BgColor_Gray];
    }
    return _topLineView;
}

- (UIView *)bottomLineView
{
    if (!_bottomLineView)
    {
        _bottomLineView = [UIView new];
        [_bottomLineView setBackgroundColor:BgColor_Gray];
    }
    return _bottomLineView;
}

- (UIView *)bottomView
{
    if (!_bottomView)
    {
        _bottomView = [UIView new];
        [_bottomView setBackgroundColor:BgColor_Gray];
    }
    return _bottomView;
}

- (UIButton *)cancelButton
{
    if (!_cancelButton)
    {
        _cancelButton = [UIButton new];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(onClickCancelButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIButton *)confirmButton
{
    if (!_confirmButton)
    {
        _confirmButton = [UIButton new];
        [_confirmButton setTitle:@"接单" forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(onClickConfirmButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

@end
