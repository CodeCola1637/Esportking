//
//  CCGainMoneyViewController.m
//  esportking
//
//  Created by CKQ on 2018/4/15.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCGainMoneyViewController.h"
#import "CCPayItemView.h"
#import "CCCommitButton.h"

@interface CCGainMoneyViewController ()<CCPayItemDelegate>

@property (assign, nonatomic) CGFloat totalMoney;

@property (strong, nonatomic) UILabel *topLabel;
@property (strong, nonatomic) CCPayItemView *wxPayItem;
@property (strong, nonatomic) CCPayItemView *zfbPayItem;
@property (strong, nonatomic) UILabel *tipsLabel;
@property (strong, nonatomic) UIView *centerView;
@property (strong, nonatomic) UILabel *moneyLabel;
@property (strong, nonatomic) UITextField *moneyField;
@property (strong, nonatomic) UIView *lineView;
@property (strong, nonatomic) UILabel *bottomLabel;
@property (strong, nonatomic) CCCommitButton *commitButton;

@end

@implementation CCGainMoneyViewController

- (instancetype)initWithMoney:(CGFloat)totalMoney
{
    if (self = [super init])
    {
        self.totalMoney = totalMoney;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configTopbar];
    [self configContent];
}

- (void)configTopbar
{
    [self addTopPopBackButton];
    [self addTopbarTitle:@"提现"];
}

- (void)configContent
{
    [self setContentWithTopOffset:LMStatusBarHeight+LMTopBarHeight bottomOffset:LMLayoutAreaBottomHeight];
    [self.contentView setBackgroundColor:BgColor_SuperLightGray];
    
    [self.contentView addSubview:self.tipsLabel];
    [self.contentView addSubview:self.wxPayItem];
    [self.contentView addSubview:self.zfbPayItem];
    [self.contentView addSubview:self.tipsLabel];
    [self.contentView addSubview:self.centerView];
    [self.contentView addSubview:self.commitButton];
    
    [self.centerView addSubview:self.moneyLabel];
    [self.centerView addSubview:self.moneyField];
    [self.centerView addSubview:self.lineView];
    [self.centerView addSubview:self.bottomLabel];
    
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(CCPXToPoint(40));
        make.left.equalTo(self.contentView).offset(CCHorMargin);
    }];
    [self.wxPayItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tipsLabel.mas_bottom).offset(CCPXToPoint(10));
        make.left.right.equalTo(self.contentView);
    }];
    [self.zfbPayItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.wxPayItem.mas_bottom);
        make.left.right.equalTo(self.wxPayItem);
    }];
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.zfbPayItem.mas_bottom).offset(CCPXToPoint(40));
        make.left.equalTo(self.topLabel);
    }];
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tipsLabel.mas_bottom).offset(CCPXToPoint(10));
        make.left.right.equalTo(self.contentView);
    }];
    [self.commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(CCPXToPoint(96));
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.centerView).offset(CCHorMargin);
        make.top.equalTo(self.centerView).offset(CCPXToPoint(20));
    }];
    [self.moneyField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.moneyLabel);
        make.left.equalTo(self.moneyLabel);
        make.right.equalTo(self.centerView).offset(-CCHorMargin);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.moneyLabel).offset(CCPXToPoint(20));
        make.left.right.equalTo(self.centerView);
        make.height.mas_equalTo(CCOnePoint);
    }];
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom);
        make.bottom.equalTo(self.centerView);
        make.left.equalTo(self.centerView).offset(CCHorMargin);
        make.right.equalTo(self.centerView).offset(-CCHorMargin);
    }];
}

#pragma mark - CCPayItemDelegate
- (void)onSelectPayItem:(PAYWAY)way
{
    
}

#pragma mark - Action
- (void)onClickCommitButton:(id)sender
{
    
}

#pragma mark - getter
- (UILabel *)topLabel
{
    if (!_topLabel)
    {
        _topLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_Dark];
        [_topLabel setText:@"提现渠道"];
    }
    return _topLabel;
}

- (CCPayItemView *)wxPayItem
{
    if (!_wxPayItem)
    {
        _wxPayItem = [[CCPayItemView alloc] initWithPayWay:PAYWAY_WX del:self];
        [_wxPayItem setBackgroundColor:BgColor_White];
    }
    return _wxPayItem;
}

- (CCPayItemView *)zfbPayItem
{
    if (!_zfbPayItem)
    {
        _zfbPayItem = [[CCPayItemView alloc] initWithPayWay:PAYWAY_ZFB del:self];
        [_zfbPayItem setBackgroundColor:BgColor_White];
    }
    return _zfbPayItem;
}

- (UILabel *)tipsLabel
{
    if (!_tipsLabel)
    {
        _tipsLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_Dark];
        [_tipsLabel setText:@"输入提现金额"];
    }
    return _tipsLabel;
}

- (UIView *)centerView
{
    if (!_centerView)
    {
        _centerView = [UIView new];
        [_centerView setBackgroundColor:BgColor_White];
    }
    return _centerView;
}

- (UILabel *)moneyLabel
{
    if (!_moneyLabel)
    {
        _moneyLabel = [UILabel createOneLineLabelWithFont:BoldFont_Great color:FontColor_Black];
        [_moneyLabel setText:@"¥"];
    }
    return _moneyLabel;
}

- (UITextField *)moneyField
{
    if (!_moneyField)
    {
        _moneyField = [UITextField new];
        [_moneyField setKeyboardType:UIKeyboardTypeNumberPad];
        [_moneyField setFont:BoldFont_Great];
    }
    return _moneyField;
}

- (UIView *)lineView
{
    if (!_lineView)
    {
        _lineView = [UIView new];
        [_lineView setBackgroundColor:BgColor_SuperLightGray];
    }
    return _lineView;
}

- (UILabel *)bottomLabel
{
    if (!_bottomLabel)
    {
        _bottomLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_Dark];
        [_bottomLabel setTextAlignment:NSTextAlignmentLeft];
        [_bottomLabel setText:[NSString stringWithFormat:@"可用余额%.2f元", self.totalMoney]];
    }
    return _bottomLabel;
}

- (CCCommitButton *)commitButton
{
    if (!_commitButton)
    {
        _commitButton = [CCCommitButton new];
        [_commitButton setTitle:@"提现" forState:UIControlStateNormal];
        [_commitButton addTarget:self action:@selector(onClickCommitButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commitButton;
}

@end
