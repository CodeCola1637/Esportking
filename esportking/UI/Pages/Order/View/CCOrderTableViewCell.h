//
//  CCOrderTableViewCell.h
//  esportking
//
//  Created by jaycechen on 2018/2/28.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CCOrderTableViewCellDelegate <NSObject>

- (void)onCancelOrder:(NSDictionary *)dict;
- (void)onConfirmOrder:(NSDictionary *)dict;

@end

@interface CCOrderTableViewCell : UITableViewCell

- (void)setOrderDict:(NSDictionary *)dict andDelegate:(id<CCOrderTableViewCellDelegate>)del;

@end
