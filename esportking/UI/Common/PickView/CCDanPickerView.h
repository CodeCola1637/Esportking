//
//  CCDanPickerView.h
//  esportking
//
//  Created by jaycechen on 2018/3/9.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCDanPickerView : UIView

@property (strong, nonatomic) UIPickerView *pickerView;

- (instancetype)initWithFrame:(CGRect)frame saveBlock:(void(^)(NSString *content, NSInteger selectIndex))saveBlock cancelBlock:(void(^)(void))cancelBlock;

@end
