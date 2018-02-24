//
//  CCRefreshCollectionView.h
//  esportking
//
//  Created by CKQ on 2018/2/4.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCRefreshProtocol.h"
#import "HomeCollectionLayout.h"

@interface CCRefreshCollectionView : UIView <CCRefreshProtocol>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) HomeCollectionLayout *collectionLayout;

@end
