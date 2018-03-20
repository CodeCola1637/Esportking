//
//  CCShowView.m
//  esportking
//
//  Created by jaycechen on 2018/3/6.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCShowView.h"

@interface CCShowView ()

@property (assign, nonatomic) SHOWSTATUS currentStatus;
@property (weak  , nonatomic) id<CCShowViewDelegate> delegate;

@property (strong, nonatomic) UIButton *button;

@end

@implementation CCShowView

- (instancetype)init
{
    return [self initWithFrame:CGRectMake(0, 0, CCShowViewSize.width, CCShowViewSize.height)];
}

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
    [self addSubview:self.button];
    [self.button setFrame:self.bounds];
    [self.button setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
}

- (void)setDelegate:(id<CCShowViewDelegate>)del
{
    _delegate = del;
}

- (void)setCurrentStatus:(SHOWSTATUS)status location:(CGPoint)point animated:(BOOL)animated
{
    _currentStatus = status;
    UIImage *image = nil;
    switch (status) {
        case SHOWSTATUS_UP:
        {
            image = CCIMG(@"Select_Up");
        }
            break;
        case SHOWSTATUS_DOWN:
        {
            image = CCIMG(@"Select_Down");
        }
            break;
        default:
            break;
    }
    [self.button setImage:image forState:UIControlStateNormal];
    if (animated)
    {
        [UIView animateWithDuration:.3f animations:^{
            self.frame = CGRectMake(point.x, point.y, self.width, self.height);
        }];
    }
    else
    {
        self.frame = CGRectMake(point.x, point.y, self.width, self.height);
    }
}

#pragma mark - action
- (void)onClickButton:(UIButton *)button
{
    [self.delegate didClickShowView:_currentStatus];
}

#pragma mark - getter
- (UIButton *)button
{
    if (!_button)
    {
        _button = [UIButton new];
        [_button setBackgroundImage:CCIMG(@"Select_BG") forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(onClickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

@end
