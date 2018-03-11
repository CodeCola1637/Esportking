//
//  CCBaseViewController.m
//  esportking
//
//  Created by CKQ on 2018/2/3.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCBaseViewController.h"
#import "UILabel+Create.h"

@interface CCBaseViewController ()

@property (strong, nonatomic) UILabel *toastLabel;

@end

@implementation CCBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:BgColor_White];
    
    _backgroundImgView = [UIImageView scaleFillImageView];
    [self.view addSubview:_backgroundImgView];
    [_backgroundImgView setFrame:self.view.bounds];
    [_backgroundImgView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    
    _topbarView = [[CCTopbarView alloc] init];
    [self.view addSubview:_topbarView];
    
    _contentView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_contentView];
}

- (void)setContentWithTopOffset:(CGFloat)topOffset bottomOffset:(CGFloat)bottomOffset
{
    CGRect frame = self.view.bounds;
    frame.origin.y += topOffset;
    frame.size.height -= topOffset + bottomOffset;
    _contentView.frame = frame;
}

- (void)addTopPopBackButton
{
    UIButton *button = [[UIButton alloc] init];
    [button setImage:CCIMG(@"Topbar_Back") forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [button addTarget:self action:@selector(onClickBackButton:) forControlEvents:UIControlEventTouchUpInside];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [self.topbarView layoutLeftControls:@[button] spacing:nil];
}

- (void)addTopbarTitle:(NSString *)title
{
    UILabel *titleLabel = [UILabel createOneLineLabelWithFont:Font_Large color:FontColor_Black];
    [titleLabel setText:title];
    [self.topbarView layoutMidControls:@[titleLabel] spacing:nil];
}

- (void)showToast:(NSString *)toast
{
    [self showToast:toast duration:2.f];
}

- (void)showToast:(NSString *)toast duration:(CGFloat)duration
{
    [self.toastLabel setText:toast];
    
    [UIView animateWithDuration:duration/2.f animations:^{
        [self.toastLabel setAlpha:1.f];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration/2.f animations:^{
            [self.toastLabel setAlpha:0.f];
        }];
    }];
}

- (void)beginLoading
{
    
}

- (void)endLoading
{
    
}

#pragma mark - private
- (void)onClickBackButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
- (UILabel *)toastLabel
{
    if (!_toastLabel)
    {
        _toastLabel = [UILabel createOneLineLabelWithFont:Font_Big color:FontColor_White];
        [_toastLabel setBackgroundColor:BgColor_Black];
        [self.view addSubview:_toastLabel];
        
        [_toastLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
        }];
    }
    return _toastLabel;
}

@end
