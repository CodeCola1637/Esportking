//
//  CCBigTextFIeldView.m
//  esportking
//
//  Created by CKQ on 2018/2/4.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCBigTextFieldView.h"

@interface CCBigTextFieldView ()

@property (strong, nonatomic) UIView *lineView;

@end

@implementation CCBigTextFieldView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupUI];
        [self setupContrain];
    }
    return self;
}

- (void)setupUI
{
    [self addSubview:self.textField];
    [self addSubview:self.lineView];
}

- (void)setupContrain
{
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(CCPXToPoint(40));
        make.left.right.equalTo(self);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textField.mas_bottom).offset(CCPXToPoint(40));
        make.bottom.equalTo(self);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(CCOnePoint);
    }];
}

#pragma mark - Getters
- (CCTextField *)textField
{
    if (!_textField)
    {
        _textField = [[CCTextField alloc] init];
        [_textField setFont:Font_Large];
        [_textField setTextColor:FontColor_Black];
    }
    return _textField;
}

- (UIView *)lineView
{
    if (!_lineView)
    {
        _lineView = [UIView new];
        [_lineView setBackgroundColor:BgColor_LightGray];
    }
    return _lineView;
}

@end
