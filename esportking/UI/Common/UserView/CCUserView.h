//
//  CCUserView.h
//  esportking
//
//  Created by jaycechen on 2018/3/8.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCStarView.h"

@interface CCUserView : UIView

- (void)setEnabelBusiness:(BOOL)enable;
- (void)setEnableTouch:(BOOL)enable del:(id<CCStarViewDelegate>)del;
- (void)setStarCount:(uint32_t)count;

@end
