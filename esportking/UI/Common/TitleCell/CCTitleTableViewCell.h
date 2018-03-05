//
//  CCTitleTableViewCell.h
//  esportking
//
//  Created by jaycechen on 2018/3/2.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCBaseTableViewCell.h"

@interface CCTitleTableViewCell : CCBaseTableViewCell

- (void)setTitle:(NSString *)title subTitle:(NSString *)subTitle subTitleColor:(UIColor *)color;
- (void)changeSubTitle:(NSString *)subTitle subTitleColor:(UIColor *)color;
- (void)enableArrow:(BOOL)enable;

@end
