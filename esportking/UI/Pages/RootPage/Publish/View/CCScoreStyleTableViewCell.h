//
//  CCScoreStyleTableViewCell.h
//  esportking
//
//  Created by jaycechen on 2018/3/2.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CCScoreStyleTableViewCellDelegate<NSObject>

- (void)didSelectScoreStyle:(SCORESTYLE)style;

@end

@interface CCScoreStyleTableViewCell : UITableViewCell

- (void)setDelegate:(id<CCScoreStyleTableViewCellDelegate>)del;

@end
