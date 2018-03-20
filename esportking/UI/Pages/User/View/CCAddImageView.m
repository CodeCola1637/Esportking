//
//  CCAddImageView.m
//  esportking
//
//  Created by jaycechen on 2018/3/12.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCAddImageView.h"

@interface CCAddImageView ()

@property (strong, nonatomic) UIImageView *contentImgView;
@property (strong, nonatomic) UIImageView *deleteImgView;

@end

@implementation CCAddImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupUI];
        [self setupGesture];
    }
    return self;
}

- (void)setupUI
{
    [self addSubview:self.contentImgView];
    [self addSubview:self.deleteImgView];
    
    [self.contentImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).offset(CCPXToPoint(12));
        make.bottom.right.equalTo(self).offset(-CCPXToPoint(12));
    }];
    [self.deleteImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self);
        make.width.height.mas_equalTo(CCPXToPoint(36));
    }];
    [self.deleteImgView setHidden:YES];
}

- (void)setupGesture
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapContent:)];
    [self addGestureRecognizer:tapGesture];
}

#pragma mark - public
- (void)setImage:(UIImage *)img
{
    [self.contentImgView setImage:img];
}

- (void)setImageWithUrl:(NSString *)url placeholder:(UIImage *)placeholder
{
    _coverUrl = url;
    [self.contentImgView setImageWithUrl:url placeholder:placeholder];
}

- (void)setCurrentStatus:(ADDIMGSTATUS)currentStatus
{
    _currentStatus = currentStatus;
    if (_currentStatus == ADDIMGSTATUS_DELETE)
    {
        [self.deleteImgView setHidden:NO];
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        
        //设置属性，周期时长
        [animation setDuration:0.1];
        //抖动角度
        animation.fromValue = @(-M_1_PI/2);
        animation.toValue = @(M_1_PI/2);
        //重复次数，无限大
        animation.repeatCount = HUGE_VAL;
        //恢复原样
        animation.autoreverses = YES;
        //锚点设置为图片中心，绕中心抖动
        self.layer.anchorPoint = CGPointMake(0.5, 0.5);
        
        [self.layer addAnimation:animation forKey:@"rotation"];
    }
    else
    {
        [self.deleteImgView setHidden:YES];
        [self.layer removeAllAnimations];
    }
}

#pragma mark - action
- (void)onTapContent:(UIGestureRecognizer *)gesture
{
    [self.delegate onClickAddImgViewWithStatus:_currentStatus sender:self];
}

#pragma mark - getter
- (UIImageView *)contentImgView
{
    if (!_contentImgView)
    {
        _contentImgView = [UIImageView scaleFillImageView];
        [_contentImgView.layer setCornerRadius:CCPXToPoint(6)];
        [_contentImgView.layer setBorderWidth:CCOnePoint];
        [_contentImgView.layer setBorderColor:BgColor_SuperLightGray.CGColor];
    }
    return _contentImgView;
}

- (UIImageView *)deleteImgView
{
    if (!_deleteImgView)
    {
        _deleteImgView = [UIImageView scaleFillImageView];
        [_deleteImgView setImage:CCIMG(@"Delete_Icon")];
    }
    return _deleteImgView;
}

@end
