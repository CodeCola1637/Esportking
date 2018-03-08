//
//  UIView+Wave.h
//  esportking
//
//  Created by jaycechen on 2018/3/8.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Wave)

- (void)startWaveAnimationWithDiameter:(CGFloat)diameter color:(UIColor *)color duration:(CGFloat)duration;
- (void)stopWaveAnimation;

@end
