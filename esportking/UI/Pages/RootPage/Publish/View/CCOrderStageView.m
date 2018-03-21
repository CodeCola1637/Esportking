//
//  CCOrderStageView.m
//  esportking
//
//  Created by jaycechen on 2018/3/8.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCOrderStageView.h"

#define kNormalColor    [UIColor colorWithRGBHex:0xb4becc]
#define kHighlightColor [UIColor colorWithRGBHex:0xffae00]

@interface CCOrderStageView ()

@property (assign, nonatomic) ORDERSTAGE currentStage;

@property (strong, nonatomic) UILabel *firstStageImgView;
@property (strong, nonatomic) UILabel *secondStageImgView;
@property (strong, nonatomic) UILabel *thirdStageImgView;
@property (strong, nonatomic) UILabel *fourthStageImgView;

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
    
    [self.firstStageImgView setTextColor:kNormalColor];
    [self.secondStageImgView setTextColor:kNormalColor];
    [self.thirdStageImgView setTextColor:kNormalColor];
    [self.fourthStageImgView setTextColor:kNormalColor];
    
    [self.firstStageImgView.layer setBorderColor:kNormalColor.CGColor];
    [self.secondStageImgView.layer setBorderColor:kNormalColor.CGColor];
    [self.thirdStageImgView.layer setBorderColor:kNormalColor.CGColor];
    [self.fourthStageImgView.layer setBorderColor:kNormalColor.CGColor];
    
    [self.firstStageLabel setTextColor:kNormalColor];
    [self.secondStageLabel setTextColor:kNormalColor];
    [self.thirdStageLabel setTextColor:kNormalColor];
    [self.fourthStageLabel setTextColor:kNormalColor];
    
    [self.secondStageLine setBackgroundColor:kNormalColor];
    [self.thirdStageLine setBackgroundColor:kNormalColor];
    [self.fourthStageLine setBackgroundColor:kNormalColor];
    
    switch (stage) {
        case ORDERSTAGE_SEARCH:
        {
            [self.firstStageImgView setTextColor:kHighlightColor];
            [self.firstStageImgView.layer setBorderColor:kHighlightColor.CGColor];
            [self.firstStageLabel setTextColor:kHighlightColor];
        }
            break;
        case ORDERSTAGE_WAIT:
        {
            [self.firstStageImgView setTextColor:kHighlightColor];
            [self.firstStageImgView.layer setBorderColor:kHighlightColor.CGColor];
            [self.secondStageImgView setTextColor:kHighlightColor];
            [self.secondStageImgView.layer setBorderColor:kHighlightColor.CGColor];
            
            [self.secondStageLabel setTextColor:kHighlightColor];
            
            [self.secondStageLine setBackgroundColor:kHighlightColor];
        }
            break;
        case ORDERSTAGE_START:
        {
            [self.firstStageImgView setTextColor:kHighlightColor];
            [self.firstStageImgView.layer setBorderColor:kHighlightColor.CGColor];
            [self.secondStageImgView setTextColor:kHighlightColor];
            [self.secondStageImgView.layer setBorderColor:kHighlightColor.CGColor];
            [self.thirdStageImgView setTextColor:kHighlightColor];
            [self.thirdStageImgView.layer setBorderColor:kHighlightColor.CGColor];
            
            [self.thirdStageLabel setTextColor:kHighlightColor];
            
            [self.secondStageLine setBackgroundColor:kHighlightColor];
            [self.thirdStageLine setBackgroundColor:kHighlightColor];
        }
            break;
        case ORDERSTAGE_FINISH:
        {
            [self.firstStageImgView setTextColor:kHighlightColor];
            [self.firstStageImgView.layer setBorderColor:kHighlightColor.CGColor];
            [self.secondStageImgView setTextColor:kHighlightColor];
            [self.secondStageImgView.layer setBorderColor:kHighlightColor.CGColor];
            [self.thirdStageImgView setTextColor:kHighlightColor];
            [self.thirdStageImgView.layer setBorderColor:kHighlightColor.CGColor];
            [self.fourthStageImgView setTextColor:kHighlightColor];
            [self.fourthStageImgView.layer setBorderColor:kHighlightColor.CGColor];
            
            [self.fourthStageLabel setTextColor:kHighlightColor];
            
            [self.secondStageLine setBackgroundColor:kHighlightColor];
            [self.thirdStageLine setBackgroundColor:kHighlightColor];
            [self.fourthStageLine setBackgroundColor:kHighlightColor];
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
- (UILabel *)firstStageImgView
{
    if (!_firstStageImgView)
    {
        _firstStageImgView = [UILabel createOneLineLabelWithFont:Font_Middle color:kNormalColor];
        [_firstStageImgView setText:@"1"];
        [_firstStageImgView.layer setCornerRadius:CCPXToPoint(40)/2.f];
        [_firstStageImgView.layer setBorderWidth:CCOnePoint];
        [_firstStageImgView.layer setBorderColor:kNormalColor.CGColor];
    }
    return _firstStageImgView;
}

- (UILabel *)secondStageImgView
{
    if (!_secondStageImgView)
    {
        _secondStageImgView = [UILabel createOneLineLabelWithFont:Font_Middle color:kNormalColor];
        [_secondStageImgView setText:@"2"];
        [_secondStageImgView.layer setCornerRadius:CCPXToPoint(40)/2.f];
        [_secondStageImgView.layer setBorderWidth:CCOnePoint];
        [_secondStageImgView.layer setBorderColor:kNormalColor.CGColor];
    }
    return _secondStageImgView;
}

- (UILabel *)thirdStageImgView
{
    if (!_thirdStageImgView)
    {
        _thirdStageImgView = [UILabel createOneLineLabelWithFont:Font_Middle color:kNormalColor];
        [_thirdStageImgView setText:@"3"];
        [_thirdStageImgView.layer setCornerRadius:CCPXToPoint(40)/2.f];
        [_thirdStageImgView.layer setBorderWidth:CCOnePoint];
        [_thirdStageImgView.layer setBorderColor:kNormalColor.CGColor];
    }
    return _thirdStageImgView;
}

- (UILabel *)fourthStageImgView
{
    if (!_fourthStageImgView)
    {
        _fourthStageImgView = [UILabel createOneLineLabelWithFont:Font_Middle color:kNormalColor];
        [_fourthStageImgView setText:@"4"];
        [_fourthStageImgView.layer setCornerRadius:CCPXToPoint(40)/2.f];
        [_fourthStageImgView.layer setBorderWidth:CCOnePoint];
        [_fourthStageImgView.layer setBorderColor:kNormalColor.CGColor];
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
