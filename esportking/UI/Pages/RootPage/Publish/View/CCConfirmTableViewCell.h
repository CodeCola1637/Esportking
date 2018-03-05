//
//  CCOrderTableViewCell.h
//  esportking
//
//  Created by jaycechen on 2018/3/2.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CCConfirmTableViewCellDelegate <NSObject>

- (void)onSelectOrder;

@end

@interface CCConfirmTableViewCell : UITableViewCell

- (void)setPrice:(uint64_t)price andDelegate:(id<CCConfirmTableViewCellDelegate>)del;

@end
