//
//  CCBaseViewController.h
//  esportking
//
//  Created by CKQ on 2018/2/3.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCTopbarView.h"

@interface CCBaseViewController : UIViewController

@property (strong, nonatomic) UIImageView *backgroundImgView;
@property (strong, nonatomic) CCTopbarView *topbarView;
@property (strong, nonatomic) UIView *contentView;

- (void)setContentWithTopOffset:(CGFloat)topOffset bottomOffset:(CGFloat)bottomOffset;
- (void)addTopPopBackButton;
- (void)addTopbarTitle:(NSString *)title;

- (void)showToast:(NSString *)toast;
- (void)showToast:(NSString *)toast duration:(CGFloat)duration;

- (void)beginLoading;
- (void)endLoading;

@end
