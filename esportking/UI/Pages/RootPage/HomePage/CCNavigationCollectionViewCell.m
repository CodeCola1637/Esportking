//
//  CCNavigationCollectionViewCell.m
//  esportking
//
//  Created by CKQ on 2018/2/11.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCNavigationCollectionViewCell.h"
#import "UILabel+Create.h"

#define kNavigationItemSize CGSizeMake(50, 50)

@interface CCNavigationView : UIView

@property (strong, nonatomic) UIImageView   *imageView;
@property (strong, nonatomic) UILabel       *label;

@end

@implementation CCNavigationView

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
    [self addSubview:self.imageView];
    [self addSubview:self.label];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(kNavigationItemSize);
    }];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(26, 26));
    }];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.centerX.equalTo(self);
    }];
}

#pragma mark - getters
- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [UIImageView new];
        [_imageView setContentMode:UIViewContentModeScaleAspectFill];
    }
    return _imageView;
}

- (UILabel *)label
{
    if (!_label)
    {
        _label = [UILabel createOneLineLabelWithFont:Font_Middle color:FontColor_Black];
    }
    return _label;
}

@end

@interface CCNavigationCollectionViewCell()

@property (weak  , nonatomic) id<CCNavigationDelegate> delegate;
@property (strong, nonatomic) CCNavigationView *nearbyView;
@property (strong, nonatomic) CCNavigationView *carView;
@property (strong, nonatomic) CCNavigationView *studyView;
@property (strong, nonatomic) CCNavigationView *beautyView;

@end

@implementation CCNavigationCollectionViewCell

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
    [self.contentView addSubview:self.nearbyView];
    [self.contentView addSubview:self.carView];
    [self.contentView addSubview:self.studyView];
    [self.contentView addSubview:self.beautyView];
    
    CGFloat offset = ceilf((LM_SCREEN_WIDTH-4*kNavigationItemSize.width)/8.f);
    [self.nearbyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(offset);
        make.centerY.equalTo(self.contentView);
    }];
    [self.carView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nearbyView.mas_right).offset(offset*2);
        make.centerY.equalTo(self.contentView);
    }];
    [self.studyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.beautyView.mas_left).offset(-2*offset);
        make.centerY.equalTo(self.contentView);
    }];
    [self.beautyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-offset);
        make.centerY.equalTo(self.contentView);
    }];
}

- (void)setDelegate:(id<CCNavigationDelegate>)delegate
{
    _delegate = delegate;
}

#pragma mark - action
- (void)onTapNavigation:(UIGestureRecognizer *)gesture
{
    [self.delegate didSelectNavigationCategory:gesture.view.tag];
}

#pragma mark - getters
- (CCNavigationView *)nearbyView
{
    if (!_nearbyView)
    {
        _nearbyView = [CCNavigationView new];
        [_nearbyView.imageView setImage:CCIMG(@"Location_Icon")];
        [_nearbyView.label setText:@"附近的人"];
        _nearbyView.tag = CATEGORY_NEARBY;
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapNavigation:)];
        [_nearbyView addGestureRecognizer:gesture];
    }
    return _nearbyView;
}

- (CCNavigationView *)carView
{
    if (!_carView)
    {
        _carView = [CCNavigationView new];
        [_carView.imageView setImage:CCIMG(@"Car_Icon")];
        [_carView.label setText:@"王者专车"];
        _carView.tag = CATEGORY_CAR;
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapNavigation:)];
        [_carView addGestureRecognizer:gesture];
    }
    return _carView;
}
- (CCNavigationView *)studyView
{
    if (!_studyView)
    {
        _studyView = [CCNavigationView new];
        [_studyView.imageView setImage:CCIMG(@"Study_Icon")];
        [_studyView.label setText:@"竞技学堂"];
        _studyView.tag = CATEGORY_STUDY;
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapNavigation:)];
        [_studyView addGestureRecognizer:gesture];
    }
    return _studyView;
}
- (CCNavigationView *)beautyView
{
    if (!_beautyView)
    {
        _beautyView = [CCNavigationView new];
        [_beautyView.imageView setImage:CCIMG(@"Beauty_Icon")];
        [_beautyView.label setText:@"美女陪玩"];
        _beautyView.tag = CATEGORY_BEAUTY;
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapNavigation:)];
        [_beautyView addGestureRecognizer:gesture];
    }
    return _beautyView;
}

@end
