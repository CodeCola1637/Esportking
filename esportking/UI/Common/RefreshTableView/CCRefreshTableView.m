//
//  CCRefreshTableView.m
//  esportking
//
//  Created by CKQ on 2018/2/4.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCRefreshTableView.h"

#import <MJRefresh.h>

@implementation CCRefreshTableView
{
    __weak id<CCRefreshDelegate> _refreshDelegate;
    MJRefreshHeader *_header;
    MJRefreshFooter *_footer;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupUI];
        [self setupConstrain];
    }
    return self;
}

- (void)setupUI
{
    _tableView = [[UITableView alloc] initWithFrame:self.frame];
    [self addSubview:_tableView];
    
    _header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(onHeaderRefresh)];
    _tableView.mj_header = _header;
    
    _footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(onFooterRefresh)];
    _tableView.mj_footer = _footer;
}

- (void)setupConstrain
{
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

#pragma mark - CCRefreshProtocol
- (void)setRefreshDelegate:(id<CCRefreshDelegate>)delegate
{
    _refreshDelegate = delegate;
}

- (void)enableHeader:(BOOL)enable
{
    _tableView.mj_header = enable?_header:nil;
}

- (void)enableFooter:(BOOL)enable
{
    _tableView.mj_footer = enable?_footer:nil;
}

- (void)beginHeaderRefreshing
{
    [_tableView.mj_header beginRefreshing];
}

- (void)reloadData
{
    [_tableView reloadData];
    [self endRefresh];
}

- (void)endRefresh
{
    [_tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshing];
}

#pragma mark -
- (void)onHeaderRefresh
{
    if (_refreshDelegate && [_refreshDelegate respondsToSelector:@selector(onHeaderRefresh)])
    {
        [_refreshDelegate onHeaderRefresh];
    }
}

- (void)onFooterRefresh
{
    if (_refreshDelegate && [_refreshDelegate respondsToSelector:@selector(onFooterRefresh)])
    {
        [_refreshDelegate onFooterRefresh];
    }
}

@end
