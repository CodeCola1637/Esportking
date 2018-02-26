//
//  CCUserCommentTableViewCell.h
//  esportking
//
//  Created by CKQ on 2018/2/25.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCCommentModel.h"

@interface CCUserCommentTableViewCell : UITableViewCell

+ (CGFloat)heightWithComment:(CCCommentModel *)comment;

- (void)setCommentModel:(CCCommentModel *)model;

@end
