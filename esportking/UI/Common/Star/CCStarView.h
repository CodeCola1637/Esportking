//
//  CCStarView.h
//  esportking
//
//  Created by CKQ on 2018/2/25.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CCStarViewDelegate <NSObject>

- (void)didSelectStarCount:(uint32_t)starCount;

@end

@interface CCStarView : UIView

- (instancetype)initWithFrame:(CGRect)frame starGap:(CGFloat)gap;
- (void)setEvaluateStarCount:(uint32_t)starCount;
- (void)setEnableTouch:(BOOL)enable del:(id<CCStarViewDelegate>)del;

@end
