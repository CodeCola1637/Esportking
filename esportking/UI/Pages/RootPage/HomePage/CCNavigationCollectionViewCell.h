//
//  CCNavigationCollectionViewCell.h
//  esportking
//
//  Created by CKQ on 2018/2/11.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CATEGORY_NEARBY,
    CATEGORY_CAR,
    CATEGORY_STUDY,
    CATEGORY_BEAUTY,
} CATEGORY;

@protocol CCNavigationDelegate <NSObject>

- (void)didSelectNavigationCategory:(CATEGORY)category;

@end

@interface CCNavigationCollectionViewCell : UICollectionViewCell

- (void)setDelegate:(id<CCNavigationDelegate>)delegate;

@end
