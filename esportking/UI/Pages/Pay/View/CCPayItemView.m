//
//  CCPayItemView.m
//  esportking
//
//  Created by CKQ on 2018/3/14.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCPayItemView.h"

@interface CCPayItemView ()

@property (weak  , nonatomic) id<CCPayItemDelegate> delegate;
@property (assign, nonatomic) PAYWAY way;

@property (strong, nonatomic) UIImageView *wayImgView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *descLabel;
@property (strong, nonatomic) UIImageView *selectImgView;

@end

@implementation CCPayItemView

- (instancetype)initWithPayWay:(PAYWAY)way del:(id<CCPayItemDelegate>)delegate
{
    if (self = [super init])
    {
        self.way = way;
        self.delegate = delegate;
        [self setupUI];
        [self setupData];
    }
    return self;
}

- (void)setupUI
{
    [self addSubview:self.wayImgView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.descLabel];
    [self addSubview:self.selectImgView];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CCPXToPoint(144));
    }];
    [self.wayImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(CCHorMargin);
        make.top.equalTo(self).offset(CCPXToPoint(24));
        make.width.height.mas_equalTo(CCPXToPoint(96));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.wayImgView.mas_right).offset(CCPXToPoint(32));
        make.top.equalTo(self).offset(CCPXToPoint(32));
    }];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(CCPXToPoint(20));
    }];
    [self.selectImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-CCPXToPoint(40));
        make.centerY.equalTo(self);
    }];
}

- (void)setupData
{
    switch (self.way)
    {
        case PAYWAY_WX:
        {
            [self.wayImgView setImage:CCIMG(@"Pay_WeChat")];
            [self.titleLabel setText:@"微信"];
            [self.descLabel setText:@"推荐安装微信9.0以上版本使用"];
        }
            break;
        case PAYWAY_ZFB:
        {
            [self.wayImgView setImage:CCIMG(@"Pay_ZhiFuBao")];
            [self.titleLabel setText:@"支付宝"];
            [self.descLabel setText:@"推荐安装支付宝9.0以上版本使用"];
        }
            break;
        case PAYWAY_ZHYE:
        {
            [self.wayImgView setImage:CCIMG(@"Pay_YuE")];
            [self.titleLabel setText:@"账户余额"];
            [self.descLabel setText:@"使用账户中的余额支付"];
        }
            break;
        case PAYWAY_CARD:
        {
            [self.wayImgView setImage:CCIMG(@"Pay_Card")];
            [self.titleLabel setText:@"体验卡"];
            [self.descLabel setText:@"使用体验卡抵用"];
        }
            break;
            
        default:
            break;
    }
}

- (void)setSelected:(BOOL)selected
{
    UIImage *image = selected ? CCIMG(@"Pay_Selected") :CCIMG(@"Pay_UnSelected");
    [self.selectImgView setImage:image];
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
        [self.delegate onSelectPayItem:self.way];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    [self setBackgroundColor:BgColor_Clear];
}

#pragma mark - getter
- (UIImageView *)wayImgView
{
    if (!_wayImgView)
    {
        _wayImgView = [UIImageView scaleFillImageView];
    }
    return _wayImgView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [UILabel createOneLineLabelWithFont:BoldFont_Big color:FontColor_Black];
    }
    return _titleLabel;
}

- (UILabel *)descLabel
{
    if (!_descLabel)
    {
        _descLabel = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_Gray];
    }
    return _descLabel;
}

- (UIImageView *)selectImgView
{
    if (!_selectImgView)
    {
        _selectImgView = [UIImageView scaleFillImageView];
    }
    return _selectImgView;
}

@end
