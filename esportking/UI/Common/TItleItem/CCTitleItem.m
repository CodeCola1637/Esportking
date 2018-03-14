//
//  CCTitleItem.m
//  esportking
//
//  Created by CKQ on 2018/2/6.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCTitleItem.h"
#import "UILabel+Create.h"

@interface CCTitleItem ()

@end

@implementation CCTitleItem

- (instancetype)initWithTitle:(NSString *)title subTitle:(NSString *)subTitle subTitleColor:(UIColor *)color delegate:(id<CCTitleItemDelegate>)del
{
    if (self = [super init])
    {
        [self addSubview:self.titleLabel];
        [self addSubview:self.subTitleLabel];
        [self addSubview:self.arrowImgView];
        [self addSubview:self.lineView];
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(CCPXToPoint(120));
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(CCPXToPoint(12));
        }];
        [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self.arrowImgView.mas_left).offset(-CCPXToPoint(26));
        }];
        [self.arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self).offset(-CCPXToPoint(12));;
        }];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.mas_equalTo(CCOnePoint);
        }];
        
        _delegate = del;
        [self.titleLabel setText:title];
        [self.subTitleLabel setText:subTitle];
        [self.subTitleLabel setTextColor:color];
    }
    return self;
}

- (void)changeSubTitle:(NSString *)subTitle subTitleColor:(UIColor *)color
{
    [self.subTitleLabel setText:subTitle];
    [self.subTitleLabel setTextColor:color];
}

- (void)setArrowHidden:(BOOL)hidden
{
    [self.arrowImgView setHidden:YES];
    [self.subTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        if (hidden)
        {
            make.right.equalTo(self.arrowImgView);
        }
        else
        {
            make.right.equalTo(self.arrowImgView.mas_left).offset(-CCPXToPoint(26));
        }
    }];

}

#pragma mark - action
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self setBackgroundColor:BgColor_Gray];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [self setBackgroundColor:BgColor_Clear];
    CGPoint location = [[touches anyObject] locationInView:self];
    if (location.x > 0 && location.y > 0)
    {
        [self.delegate onClickTitleItem:self];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    [self setBackgroundColor:BgColor_Clear];
}

#pragma mark - getters
- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [UILabel createOneLineLabelWithFont:Font_Large color:FontColor_Black];
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel
{
    if (!_subTitleLabel)
    {
        _subTitleLabel = [UILabel createOneLineLabelWithFont:Font_Big color:FontColor_LightGray];
    }
    return _subTitleLabel;
}

- (UIImageView *)arrowImgView
{
    if (!_arrowImgView)
    {
        _arrowImgView = [[UIImageView alloc] initWithImage:CCIMG(@"Right_Arrow")];
        [_arrowImgView setContentMode:UIViewContentModeScaleAspectFit];
    }
    return _arrowImgView;
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

@end
