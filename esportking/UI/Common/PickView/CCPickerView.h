//
//  CCPickerView.h
//  esportking
//
//  Created by jaycechen on 2018/3/6.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCPickerView : UIView

@property (strong, nonatomic) UIPickerView *pickerView;

- (instancetype)initWithFrame:(CGRect)frame data:(NSArray<NSString *> *)dataList saveBlock:(void(^)(NSString *content, NSInteger selectIndex))saveBlock cancelBlock:(void(^)(void))cancelBlock;

@end
