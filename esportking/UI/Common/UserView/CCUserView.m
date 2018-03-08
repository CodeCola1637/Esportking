//
//  CCUserView.m
//  esportking
//
//  Created by jaycechen on 2018/3/8.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCUserView.h"
#import "CCGenderOldView.h"

#define kHeadWidth  CCPXToPoint(140)

@interface CCUserView ()

@property (strong, nonatomic) UIImageView *headImgView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) CCGenderOldView *genderView;
@property (strong, nonatomic) UILabel *businessLabel;
@property (strong, nonatomic) CCStarView *starView;

@end

@implementation CCUserView

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
    [self addSubview:self.headImgView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.genderView];
    [self addSubview:self.businessLabel];
    [self addSubview:self.starView];
    
    [self.headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.equalTo(self);
        make.width.height.mas_equalTo(kHeadWidth);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImgView.mas_bottom).offset(CCPXToPoint(16));
        make.centerX.equalTo(self);
    }];
    [self.genderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.nameLabel);
        make.left.equalTo(self.nameLabel.mas_right).offset(CCPXToPoint(4));
        make.height.mas_equalTo(CCPXToPoint(30));
    }];
    [self.businessLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(CCPXToPoint(20));
        make.centerX.equalTo(self);
    }];
    [self.starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.bottom.equalTo(self);
    }];
}

#pragma mark - public
- (void)setEnabelBusiness:(BOOL)enable
{
    [self.businessLabel setHidden:!enable];
}

- (void)setEnableTouch:(BOOL)enable del:(id<CCStarViewDelegate>)del
{
    [self.starView setEnableTouch:enable del:del];
}

- (void)setStarCount:(uint32_t)count
{
    [self.starView setEvaluateStarCount:count];
}

#pragma mark - getter
- (UIImageView *)headImgView
{
    if (!_headImgView)
    {
        _headImgView = [UIImageView scaleFillImageView];
    }
    return _headImgView;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel)
    {
        _nameLabel = [UILabel createOneLineLabelWithFont:Font_Big color:FontColor_Black];
    }
    return _nameLabel;
}

- (CCGenderOldView *)genderView
{
    if (!_genderView)
    {
        _genderView = [CCGenderOldView new];
        [_genderView.layer setCornerRadius:CCPXToPoint(15)];
    }
    return _genderView;
}

- (UILabel *)businessLabel
{
    if (!_businessLabel)
    {
        _businessLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_Gray];
    }
    return _businessLabel;
}

- (CCStarView *)starView
{
    if (!_starView)
    {
        _starView = [[CCStarView alloc] initWithFrame:CGRectMake(0, 0, CCPXToPoint(294), CCPXToPoint(40)) starGap:CCPXToPoint(22)];
    }
    return _starView;
}

@end
