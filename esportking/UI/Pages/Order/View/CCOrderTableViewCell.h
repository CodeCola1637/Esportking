//
//  CCOrderTableViewCell.h
//  esportking
//
//  Created by jaycechen on 2018/2/28.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCOrderModel.h"

@protocol CCOrderTableViewCellDelegate <NSObject>

- (void)onCancelOrder:(CCOrderModel *)orderModel;
- (void)onConfirmOrder:(CCOrderModel *)orderModel;

@end

@interface CCOrderTableViewCell : UITableViewCell

- (void)setOrderDict:(CCOrderModel *)model andDelegate:(id<CCOrderTableViewCellDelegate>)del;

@end
