//
//  CCOrderStageView.m
//  esportking
//
//  Created by jaycechen on 2018/3/8.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCOrderStageView.h"

@interface CCOrderStageView ()

@property (assign, nonatomic) ORDERSTAGE currentStage;

@property (strong, nonatomic) UIImageView *firstStageImgView;
@property (strong, nonatomic) UIImageView *secondStageImgView;
@property (strong, nonatomic) UIImageView *thirdStageImgView;
@property (strong, nonatomic) UIImageView *fourthStageImgView;

@property (strong, nonatomic) UILabel *firstStageLabel;
@property (strong, nonatomic) UILabel *secondStageLabel;
@property (strong, nonatomic) UILabel *thirdStageLabel;
@property (strong, nonatomic) UILabel *fourthStageLabel;

@property (strong, nonatomic) UIView *secondStageLine;
@property (strong, nonatomic) UIView *thirdStageLine;
@property (strong, nonatomic) UIView *fourthStageLine;

@property (strong, nonatomic) UIImageView *bottomBGImgView;

@end

@implementation CCOrderStageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    [self addSubview:self.bottomBGImgView];
    
    [self addSubview:self.firstStageImgView];
    [self addSubview:self.secondStageImgView];
    [self addSubview:self.thirdStageImgView];
    [self addSubview:self.fourthStageImgView];
    
    [self addSubview:self.firstStageLabel];
    [self addSubview:self.secondStageLabel];
    [self addSubview:self.thirdStageLabel];
    [self addSubview:self.fourthStageLabel];
    
    [self addSubview:self.secondStageLine];
    [self addSubview:self.thirdStageLine];
    [self addSubview:self.fourthStageLine];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(LM_SCREEN_WIDTH);
        make.height.mas_equalTo(LM_SCREEN_WIDTH/self.bottomBGImgView.image.size.width*self.bottomBGImgView.image.size.height);
    }];
    
    [self.bottomBGImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    CGFloat gap = (LM_SCREEN_WIDTH-CCPXToPoint(40)*4)/8.f;
    [self.firstStageImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(gap);
        make.top.equalTo(self);
        make.width.height.mas_offset(CCPXToPoint(40));
    }];
    [self.secondStageImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.firstStageImgView.mas_right).offset(gap*2);
        make.top.equalTo(self.firstStageImgView);
        make.width.height.mas_offset(CCPXToPoint(40));
    }];
    [self.thirdStageImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.secondStageImgView.mas_right).offset(gap*2);
        make.top.equalTo(self.secondStageImgView);
        make.width.height.mas_offset(CCPXToPoint(40));
    }];
    [self.fourthStageImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.thirdStageImgView.mas_right).offset(gap*2);
        make.top.equalTo(self.thirdStageImgView);
        make.width.height.mas_offset(CCPXToPoint(40));
    }];
    
    [self.firstStageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.firstStageImgView);
        make.top.equalTo(self.firstStageImgView.mas_bottom).offset(CCPXToPoint(12));
    }];
    [self.secondStageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.secondStageImgView);
        make.top.equalTo(self.secondStageImgView.mas_bottom).offset(CCPXToPoint(12));
    }];
    [self.thirdStageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.thirdStageImgView);
        make.top.equalTo(self.thirdStageImgView.mas_bottom).offset(CCPXToPoint(12));
    }];
    [self.fourthStageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.fourthStageImgView);
        make.top.equalTo(self.fourthStageImgView.mas_bottom).offset(CCPXToPoint(12));
    }];
    
    [self.secondStageLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.firstStageImgView.mas_right);
        make.right.equalTo(self.secondStageImgView.mas_left);
        make.centerY.equalTo(self.firstStageImgView);
        make.height.mas_equalTo(CCOnePoint);
    }];
    [self.thirdStageLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.secondStageImgView.mas_right);
        make.right.equalTo(self.thirdStageImgView.mas_left);
        make.centerY.equalTo(self.firstStageImgView);
        make.height.mas_equalTo(CCOnePoint);
    }];
    [self.fourthStageLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.thirdStageImgView.mas_right);
        make.right.equalTo(self.fourthStageImgView.mas_left);
        make.centerY.equalTo(self.firstStageImgView);
        make.height.mas_equalTo(CCOnePoint);
    }];
}

- (void)setOrderStage:(ORDERSTAGE)stage
{
    _currentStage = stage;
    
    switch (stage) {
        case ORDERSTAGE_SEARCH:
        {
            [self.firstStageImgView setTintColor:[UIColor colorWithRGBHex:0xffae00]];
            [self.secondStageImgView setTintColor:[UIColor colorWithRGBHex:0xb4becc]];
            [self.thirdStageImgView setTintColor:[UIColor colorWithRGBHex:0xb4becc]];
            [self.fourthStageImgView setTintColor:[UIColor colorWithRGBHex:0xb4becc]];
            
            [self.firstStageLabel setTextColor:[UIColor colorWithRGBHex:0xff5000]];
            [self.secondStageLabel setTextColor:[UIColor colorWithRGBHex:0xb4becc]];
            [self.thirdStageLabel setTextColor:[UIColor colorWithRGBHex:0xb4becc]];
            [self.fourthStageLabel setTextColor:[UIColor colorWithRGBHex:0xb4becc]];
            
            [self.secondStageLine setBackgroundColor:[UIColor colorWithRGBHex:0xb4becc]];
            [self.thirdStageLine setBackgroundColor:[UIColor colorWithRGBHex:0xb4becc]];
            [self.fourthStageLine setBackgroundColor:[UIColor colorWithRGBHex:0xb4becc]];
        }
            break;
        case ORDERSTAGE_WAIT:
        {
            [self.firstStageImgView setTintColor:[UIColor colorWithRGBHex:0xffae00]];
            [self.secondStageImgView setTintColor:[UIColor colorWithRGBHex:0xffae00]];
            [self.thirdStageImgView setTintColor:[UIColor colorWithRGBHex:0xb4becc]];
            [self.fourthStageImgView setTintColor:[UIColor colorWithRGBHex:0xb4becc]];
            
            [self.firstStageLabel setTextColor:[UIColor colorWithRGBHex:0xb4becc]];
            [self.secondStageLabel setTextColor:[UIColor colorWithRGBHex:0xffae00]];
            [self.thirdStageLabel setTextColor:[UIColor colorWithRGBHex:0xb4becc]];
            [self.fourthStageLabel setTextColor:[UIColor colorWithRGBHex:0xb4becc]];
            
            [self.secondStageLine setBackgroundColor:[UIColor colorWithRGBHex:0xffae00]];
            [self.thirdStageLine setBackgroundColor:[UIColor colorWithRGBHex:0xb4becc]];
            [self.fourthStageLine setBackgroundColor:[UIColor colorWithRGBHex:0xb4becc]];
        }
            break;
        case ORDERSTAGE_START:
        {
            [self.firstStageImgView setTintColor:[UIColor colorWithRGBHex:0xffae00]];
            [self.secondStageImgView setTintColor:[UIColor colorWithRGBHex:0xffae00]];
            [self.thirdStageImgView setTintColor:[UIColor colorWithRGBHex:0xffae00]];
            [self.fourthStageImgView setTintColor:[UIColor colorWithRGBHex:0xb4becc]];
            
            [self.firstStageLabel setTextColor:[UIColor colorWithRGBHex:0xb4becc]];
            [self.secondStageLabel setTextColor:[UIColor colorWithRGBHex:0xb4becc]];
            [self.thirdStageLabel setTextColor:[UIColor colorWithRGBHex:0xff5000]];
            [self.fourthStageLabel setTextColor:[UIColor colorWithRGBHex:0xb4becc]];
            
            [self.secondStageLine setBackgroundColor:[UIColor colorWithRGBHex:0xffae00]];
            [self.thirdStageLine setBackgroundColor:[UIColor colorWithRGBHex:0xffae00]];
            [self.fourthStageLine setBackgroundColor:[UIColor colorWithRGBHex:0xb4becc]];
        }
            break;
        case ORDERSTAGE_FINISH:
        {
            [self.firstStageImgView setTintColor:[UIColor colorWithRGBHex:0xffae00]];
            [self.secondStageImgView setTintColor:[UIColor colorWithRGBHex:0xffae00]];
            [self.thirdStageImgView setTintColor:[UIColor colorWithRGBHex:0xffae00]];
            [self.fourthStageImgView setTintColor:[UIColor colorWithRGBHex:0xffae00]];
            
            [self.firstStageLabel setTextColor:[UIColor colorWithRGBHex:0xb4becc]];
            [self.secondStageLabel setTextColor:[UIColor colorWithRGBHex:0xb4becc]];
            [self.thirdStageLabel setTextColor:[UIColor colorWithRGBHex:0xb4becc]];
            [self.fourthStageLabel setTextColor:[UIColor colorWithRGBHex:0xffae00]];
            
            [self.secondStageLine setBackgroundColor:[UIColor colorWithRGBHex:0xffae00]];
            [self.thirdStageLine setBackgroundColor:[UIColor colorWithRGBHex:0xffae00]];
            [self.fourthStageLine setBackgroundColor:[UIColor colorWithRGBHex:0xffae00]];
        }
            break;
            
        default:
            break;
    }
}

- (ORDERSTAGE)currentOrderStage
{
    return _currentStage;
}

#pragma mark - getter
- (UIImageView *)firstStageImgView
{
    if (!_firstStageImgView)
    {
        _firstStageImgView = [UIImageView scaleFillImageView];
        [_firstStageImgView setImage:CCIMG(@"")];
    }
    return _firstStageImgView;
}

- (UIImageView *)secondStageImgView
{
    if (!_secondStageImgView)
    {
        _secondStageImgView = [UIImageView scaleFillImageView];
        [_secondStageImgView setImage:CCIMG(@"")];
    }
    return _secondStageImgView;
}

- (UIImageView *)thirdStageImgView
{
    if (!_thirdStageImgView)
    {
        _thirdStageImgView = [UIImageView scaleFillImageView];
        [_thirdStageImgView setImage:CCIMG(@"")];
    }
    return _thirdStageImgView;
}

- (UIImageView *)fourthStageImgView
{
    if (!_fourthStageImgView)
    {
        _fourthStageImgView = [UIImageView scaleFillImageView];
        [_fourthStageImgView setImage:CCIMG(@"")];
    }
    return _fourthStageImgView;
}

- (UILabel *)firstStageLabel
{
    if (!_firstStageLabel)
    {
        _firstStageLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_Black];
        [_firstStageLabel setText:@"正在召唤"];
    }
    return _firstStageLabel;
}

- (UILabel *)secondStageLabel
{
    if (!_secondStageLabel)
    {
        _secondStageLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_Black];
        [_secondStageLabel setText:@"等待接单"];
    }
    return _secondStageLabel;
}

- (UILabel *)thirdStageLabel
{
    if (!_thirdStageLabel)
    {
        _thirdStageLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_Black];
        [_thirdStageLabel setText:@"开始服务"];
    }
    return _thirdStageLabel;
}

- (UILabel *)fourthStageLabel
{
    if (!_fourthStageLabel)
    {
        _fourthStageLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_Black];
        [_fourthStageLabel setText:@"完成评价"];
    }
    return _fourthStageLabel;
}

- (UIView *)secondStageLine
{
    if (!_secondStageLine)
    {
        _secondStageLine = [UIView new];
        [_secondStageLine setBackgroundColor:BgColor_Gray];
    }
    return _secondStageLine;
}

- (UIView *)thirdStageLine
{
    if (!_thirdStageLine)
    {
        _thirdStageLine = [UIView new];
        [_thirdStageLine setBackgroundColor:BgColor_Gray];
    }
    return _thirdStageLine;
}

- (UIView *)fourthStageLine
{
    if (!_fourthStageLine)
    {
        _fourthStageLine = [UIView new];
        [_fourthStageLine setBackgroundColor:BgColor_Gray];
    }
    return _fourthStageLine;
}

- (UIImageView *)bottomBGImgView
{
    if (!_bottomBGImgView)
    {
        _bottomBGImgView = [UIImageView scaleFillImageView];
        [_bottomBGImgView setImage:CCIMG(@"Order_Stage_BG")];
    }
    return _bottomBGImgView;
}

@end
