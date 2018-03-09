//
//  CCUserView.h
//  esportking
//
//  Created by jaycechen on 2018/3/8.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCStarView.h"
#import "CCUserModel.h"

#define UserViewHeight              CCPXToPoint(312)
#define UserViewWithoutBusiHeight   CCPXToPoint(268)

@interface CCUserView : UIView

- (void)setEnabelBusiness:(BOOL)enable;
- (void)setEnableTouch:(BOOL)enable del:(id<CCStarViewDelegate>)del;
- (void)setUserInfo:(CCUserModel *)model businessCount:(uint32_t)busiCount starCount:(uint32_t)starCount;

@end
