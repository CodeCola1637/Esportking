//
//  CCSearchHistoryView.h
//  esportking
//
//  Created by jaycechen on 2018/3/5.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CCSearchHistoryViewDelegate <NSObject>

- (void)didSelectSearchHistory:(NSString *)words;

@end

@interface CCSearchHistoryView : UIView

- (instancetype)initWithDelegate:(id<CCSearchHistoryViewDelegate>)del;
- (void)reloadData;

@end
