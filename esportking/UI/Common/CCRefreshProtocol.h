//
//  CCRefreshProtocol.h
//  esportking
//
//  Created by CKQ on 2018/2/4.
//  Copyright © 2018年 wan353. All rights reserved.
//

@protocol CCRefreshDelegate <NSObject>

- (void)onHeaderRefresh;
- (void)onFooterRefresh;

@end

@protocol CCRefreshProtocol <NSObject>

- (void)setRefreshDelegate:(id<CCRefreshDelegate>)delegate;

- (void)enableHeader:(BOOL)enable;
- (void)enableFooter:(BOOL)enable;

- (void)beginHeaderRefreshing;
- (void)reloadData;
- (void)endRefresh;

@end
