//
//  CCUserPriceTableViewCell.m
//  esportking
//
//  Created by CKQ on 2018/2/25.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCUserPriceTableViewCell.h"
#import "CCLevelView.h"

@interface CCUserPriceTableViewCell ()

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *evaluateLabel;
@property (strong, nonatomic) CCLevelView *firstView;
@property (strong, nonatomic) CCLevelView *secondView;
@property (strong, nonatomic) CCLevelView *thirdView;
@property (strong, nonatomic) CCLevelView *forthView;

@end

@implementation CCUserPriceTableViewCell

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
    [self setBackgroundColor:BgColor_White];
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.evaluateLabel];
    [self.contentView addSubview:self.firstView];
    [self.contentView addSubview:self.secondView];
    [self.contentView addSubview:self.thirdView];
    [self.contentView addSubview:self.forthView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(CCPXToPoint(32));
    }];
    [self.evaluateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.titleLabel);
        make.right.equalTo(self.contentView).offset(-CCPXToPoint(32));
    }];
    
    CGFloat gap = ceilf((LM_SCREEN_WIDTH - 4*CCPXToPoint(100))/8.f);
    [self.firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(gap);
        make.bottom.equalTo(self.contentView).offset(-CCPXToPoint(39));
    }];
    [self.secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.firstView.mas_right).offset(gap*2);
        make.bottom.equalTo(self.firstView);
    }];
    [self.thirdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.secondView.mas_right).offset(gap*2);
        make.bottom.equalTo(self.firstView);
    }];
    [self.forthView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.thirdView.mas_right).offset(gap*2);
        make.bottom.equalTo(self.firstView);
    }];
}

#pragma mark - getter
- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_Black];
        [_titleLabel setText:@"他的价格"];
    }
    return _titleLabel;
}

- (UILabel *)evaluateLabel
{
    if (!_evaluateLabel)
    {
        _evaluateLabel = [UILabel createOneLineLabelWithFont:Font_Small color:FontColor_Gray];
    }
    return _evaluateLabel;
}

- (CCLevelView *)firstView
{
    if (!_firstView)
    {
        _firstView = [[CCLevelView alloc] init];
        [_firstView setLevel:LEVEL_WANGZHE andPrice:38];
    }
    return _firstView;
}

- (CCLevelView *)secondView
{
    if (!_secondView)
    {
        _secondView = [[CCLevelView alloc] init];
        [_secondView setLevel:LEVEL_XINGYAO andPrice:30];
    }
    return _secondView;
}
- (CCLevelView *)thirdView
{
    if (!_thirdView)
    {
        _thirdView = [[CCLevelView alloc] init];
        [_thirdView setLevel:LEVEL_ZUANSHI andPrice:18];
    }
    return _thirdView;
}
- (CCLevelView *)forthView
{
    if (!_forthView)
    {
        _forthView = [[CCLevelView alloc] init];
        [_forthView setLevel:LEVEL_BOJIN andPrice:12];
    }
    return _forthView;
}


@end
