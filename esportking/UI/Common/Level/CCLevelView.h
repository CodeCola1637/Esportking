//
//  CCLevelView.h
//  esportking
//
//  Created by CKQ on 2018/2/25.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    LEVEL_QINGTONG = 1,
    LEVEL_BAIYIN,
    LEVEL_HUANGJIN,
    LEVEL_BOJIN,
    LEVEL_ZUANSHI,
    LEVEL_XINGYAO,
    LEVEL_WANGZHE,
} LEVEL;

@interface CCLevelView : UIView

- (void)setLevel:(LEVEL)level andPrice:(uint32_t)price;

@end
