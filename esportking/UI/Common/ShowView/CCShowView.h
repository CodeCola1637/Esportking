//
//  CCShowView.h
//  esportking
//
//  Created by jaycechen on 2018/3/6.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CCShowViewSize  CGSizeMake(CCPXToPoint(160), CCPXToPoint(160))

typedef enum : NSUInteger {
    SHOWSTATUS_UP = 1,
    SHOWSTATUS_DOWN,
} SHOWSTATUS;

@protocol CCShowViewDelegate <NSObject>

- (void)didClickShowView:(SHOWSTATUS)status;

@end

@interface CCShowView : UIView

- (void)setDelegate:(id<CCShowViewDelegate>)del;
- (void)setCurrentStatus:(SHOWSTATUS)status location:(CGPoint)point animated:(BOOL)animated;

@end
