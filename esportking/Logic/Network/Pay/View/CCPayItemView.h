//
//  CCPayItemView.h
//  esportking
//
//  Created by CKQ on 2018/3/14.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CCPayItemHeight CCPXToPoint(144)

typedef enum : NSUInteger {
    PAYWAY_WX = 1,
    PAYWAY_ZFB,
    PAYWAY_ZHYE,
    PAYWAY_CARD,
} PAYWAY;

@protocol CCPayItemDelegate <NSObject>

- (void)onSelectPayItem:(PAYWAY)way;

@end

@interface CCPayItemView : UIView

- (instancetype)initWithPayWay:(PAYWAY)way del:(id<CCPayItemDelegate>)delegate;
- (void)setSelected:(BOOL)selected;

@end
