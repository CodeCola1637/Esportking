//
//  CCImgTitleTableViewCell.h
//  esportking
//
//  Created by CKQ on 2018/2/17.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCBaseTableViewCell.h"

@interface CCImgTitleTableViewCell : CCBaseTableViewCell

@property (strong, nonatomic) UIImageView *iconView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *subTitleLabel;
@property (strong, nonatomic) UIImageView *arrowImgView;

- (void)setIcon:(UIImage *)icon andTitle:(NSString *)title;

@end
