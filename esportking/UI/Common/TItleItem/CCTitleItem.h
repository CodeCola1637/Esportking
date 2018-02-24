//
//  CCTitleItem.h
//  esportking
//
//  Created by CKQ on 2018/2/6.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CCTitleItemDelegate <NSObject>

- (void)onClickTitleItem:(id)sender;

@end

@interface CCTitleItem : UIView

@property (weak  , nonatomic) id<CCTitleItemDelegate> delegate;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *subTitleLabel;

- (instancetype)initWithTitle:(NSString *)title subTitle:(NSString *)subTitle subTitleColor:(UIColor *)color delegate:(id<CCTitleItemDelegate>)del;
- (void)changeSubTitle:(NSString *)subTitle subTitleColor:(UIColor *)color;

@end
