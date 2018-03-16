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

#define UserViewHeight              CCPXToPoint(300)
#define UserViewWithoutBusiHeight   CCPXToPoint(250)

@interface CCUserView : UIView

- (void)setEnabelBusiness:(BOOL)enable;
- (void)setEnableTouch:(BOOL)enable del:(id<CCStarViewDelegate>)del;
- (void)setUserInfo:(CCUserModel *)model businessCount:(uint64_t)busiCount starCount:(uint64_t)starCount;

@end
