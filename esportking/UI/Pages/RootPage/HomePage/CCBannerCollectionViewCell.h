//
//  CCBannerCollectionViewCell.h
//  esportking
//
//  Created by CKQ on 2018/2/11.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CCGameModel;

@protocol CCBannerDelegate <NSObject>

- (void)didSelectBannerWithModel:(CCGameModel *)model;

@end

@interface CCBannerCollectionViewCell : UICollectionViewCell

- (void)setBannerList:(NSArray<CCGameModel *> *)list andDelegate:(id<CCBannerDelegate>)del;

@end
