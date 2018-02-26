//
//  CCTagView.h
//  esportking
//
//  Created by CKQ on 2018/2/25.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCTagModel.h"

#define TagSize CGSizeMake(CCPXToPoint(216), CCPXToPoint(57))

@interface CCTagView : UIView

- (void)setTagModel:(CCTagModel *)model withColor:(UIColor *)color;

@end
