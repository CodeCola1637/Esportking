//
//  UIView+Wave.m
//  esportking
//
//  Created by jaycechen on 2018/3/8.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "UIView+Wave.h"
#import <objc/runtime.h>

#define kPulseAnimation @"kPulseAnimation"

@implementation UIView (Wave)

- (void)startWaveAnimationWithDiameter:(CGFloat)diameter color:(UIColor *)color duration:(CGFloat)duration
{
    CALayer *waveLayer = [CALayer layer];
    waveLayer.bounds = CGRectMake(0, 0, diameter, diameter);
    waveLayer.cornerRadius = diameter / 2; //设置圆角变为圆形
    waveLayer.position = self.center;
    waveLayer.backgroundColor = [color CGColor];
    [self.superview.layer insertSublayer:waveLayer below:self.layer];//把扩散层放到播放按钮下面
    
    CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = duration;
    animationGroup.repeatCount = INFINITY; //重复无限次
    animationGroup.removedOnCompletion = NO;
    
    CAMediaTimingFunction *defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    animationGroup.timingFunction = defaultCurve;
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
    scaleAnimation.fromValue = @0.7; //开始的大小
    scaleAnimation.toValue = @1.0; //最后的大小
    scaleAnimation.duration = duration;
    scaleAnimation.removedOnCompletion = NO;
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = @0.4; //开始的大小
    opacityAnimation.toValue = @0.0; //最后的大小
    opacityAnimation.duration = duration;
    opacityAnimation.removedOnCompletion = NO;
    
    animationGroup.animations = @[scaleAnimation, opacityAnimation];
    [waveLayer addAnimation:animationGroup forKey:kPulseAnimation];
    
    NSMutableArray *list = objc_getAssociatedObject(self, kPulseAnimation);
    if (list == nil)
    {
        list = [NSMutableArray new];
    }
    [list addObject:waveLayer];
    objc_setAssociatedObject(self, kPulseAnimation, list, OBJC_ASSOCIATION_RETAIN);
}

- (void)stopWaveAnimation
{
    NSMutableArray *list = objc_getAssociatedObject(self, kPulseAnimation);
    if (list)
    {
        for (CALayer *layer in list)
        {
            [layer removeAllAnimations];
            [layer removeFromSuperlayer];
        }
        [list removeAllObjects];
    }
    objc_setAssociatedObject(self, kPulseAnimation, nil, OBJC_ASSOCIATION_RETAIN);
}

@end
