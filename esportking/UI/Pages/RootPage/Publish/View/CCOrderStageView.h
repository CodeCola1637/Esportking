//
//  CCOrderStageView.h
//  esportking
//
//  Created by jaycechen on 2018/3/8.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ORDERSTAGE_SEARCH,
    ORDERSTAGE_WAIT,
    ORDERSTAGE_START,
    ORDERSTAGE_FINISH,
} ORDERSTAGE;

@interface CCOrderStageView : UIView

- (void)setOrderStage:(ORDERSTAGE)stage;

- (ORDERSTAGE)currentOrderStage;

@end
