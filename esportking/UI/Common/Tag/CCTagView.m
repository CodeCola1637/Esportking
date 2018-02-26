//
//  CCTagView.m
//  esportking
//
//  Created by CKQ on 2018/2/25.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCTagView.h"

@interface CCTagView ()

@property (strong, nonatomic) CCTagModel *tagModel;

@property (strong, nonatomic) UILabel *tagLabel;
@property (strong, nonatomic) UIView *devideLine;
@property (strong, nonatomic) UIView *countView;
@property (strong, nonatomic) UILabel *countLabel;

@end

@implementation CCTagView

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
    [self.layer setCornerRadius:TagSize.height/2.f];
    [self.layer setBorderColor:BgColor_Gray.CGColor];
    [self.layer setBorderWidth:CCOnePoint];
    
    [self addSubview:self.tagLabel];
    [self addSubview:self.devideLine];
    [self addSubview:self.countView];
    [self.countView addSubview:self.countLabel];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(TagSize);
    }];
    [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self.devideLine.mas_left);
        make.centerY.equalTo(self);
    }];
    [self.devideLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.countView.mas_left);
        make.top.bottom.equalTo(self);
        make.width.mas_offset(CCOnePoint);
    }];
    [self.countView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(self);
        make.width.mas_equalTo(CCPXToPoint(76));
    }];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.countView);
    }];
}

- (void)setTagModel:(CCTagModel *)model withColor:(UIColor *)color
{
    self.tagModel = model;
    
    [self.tagLabel setText:model.tagName];
    [self.countLabel setText:[NSString stringWithFormat:@"%d", model.agreeCount]];
    if (color)
    {
        [self.countView setBackgroundColor:color];
        [self.devideLine setBackgroundColor:color];
        [self.layer setBorderColor:color.CGColor];
    }
}

#pragma mark - getter
- (UILabel *)tagLabel
{
    if (!_tagLabel)
    {
        _tagLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_Black];
    }
    return _tagLabel;
}

- (UIView *)devideLine
{
    if (!_devideLine)
    {
        _devideLine = [UIView new];
        [_devideLine setBackgroundColor:BgColor_Gray];
    }
    return _devideLine;
}

- (UIView *)countView
{
    if (!_countView)
    {
        _countView = [UIView new];
    }
    return _countView;
}

- (UILabel *)countLabel
{
    if (!_countLabel)
    {
        _countLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_Black];
    }
    return _countLabel;
}

@end
