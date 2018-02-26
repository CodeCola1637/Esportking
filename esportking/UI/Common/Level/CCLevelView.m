//
//  CCLevelView.m
//  esportking
//
//  Created by CKQ on 2018/2/25.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCLevelView.h"

#define kNameList @[@"青铜局", @"白银局", @"黄金局", @"铂金局", @"钻石局", @"星耀局", @"王者局"]

@interface CCLevelView ()

@property (strong, nonatomic) UIImageView *levelImgView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *priceLabel;

@end

@implementation CCLevelView

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
    [self addSubview:self.levelImgView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.priceLabel];
    
    [self.levelImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.equalTo(self);
        make.width.mas_equalTo(CCPXToPoint(80));
        make.height.mas_equalTo(CCPXToPoint(96));
        make.left.greaterThanOrEqualTo(self);
        make.right.lessThanOrEqualTo(self);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.levelImgView.mas_bottom).offset(CCPXToPoint(12));
        make.left.greaterThanOrEqualTo(self);
        make.right.lessThanOrEqualTo(self);
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(CCPXToPoint(20));
        make.bottom.equalTo(self);
        make.left.greaterThanOrEqualTo(self);
        make.right.lessThanOrEqualTo(self);
    }];
}

- (void)setLevel:(LEVEL)level andPrice:(uint32_t)price
{
    NSString *imgName = [NSString stringWithFormat:@"Level_%lu", level];
    [self.levelImgView setImage:CCIMG(imgName)];
    [self.titleLabel setText:kNameList[level-1]];
    NSMutableAttributedString *artString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%d", price] attributes:@{NSFontAttributeName:Font_Big, NSForegroundColorAttributeName:FontColor_Red}];
    [artString appendAttributedString:[[NSAttributedString alloc] initWithString:@"/局" attributes:@{NSFontAttributeName:Font_Middle, NSForegroundColorAttributeName:FontColor_Gray}]];
    [self.priceLabel setAttributedText:artString];
}

#pragma mark - getter
- (UIImageView *)levelImgView
{
    if (!_levelImgView)
    {
        _levelImgView = [UIImageView new];
        [_levelImgView setContentMode:UIViewContentModeScaleAspectFill];
        [_levelImgView setClipsToBounds:YES];
    }
    return _levelImgView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_Black];
    }
    return _titleLabel;
}

- (UILabel *)priceLabel
{
    if (!_priceLabel)
    {
        _priceLabel = [UILabel createOneLineLabelWithFont:Font_Big color:FontColor_Gray];
    }
    return _priceLabel;
}

@end
