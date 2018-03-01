//
//  CCPageContainerViewController.h
//  esportking
//
//  Created by jaycechen on 2018/2/28.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCBaseViewController.h"
#import "ZJScrollPageViewDelegate.h"

@interface CCPageContainerViewController : CCBaseViewController

- (instancetype)initWithVCs:(NSArray<UIViewController<ZJScrollPageViewChildVcDelegate> *> *)vcs subTitles:(NSArray<NSString *> *)titles andTitle:(NSString *)title;

@end
