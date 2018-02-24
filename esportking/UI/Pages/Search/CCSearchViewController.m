//
//  CCSearchViewController.m
//  esportking
//
//  Created by CKQ on 2018/2/18.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCSearchViewController.h"
#import "CCRefreshTableView.h"
#import "CCSearchTableViewCell.h"

#import "CCSearchRequest.h"

#define kSearchIdentify @"search"

@interface CCSearchViewController ()<UITableViewDelegate, UITableViewDataSource, CCRefreshDelegate, CCRequestDelegate>

@property (strong, nonatomic) NSMutableArray<CCGameModel *> *dataList;
@property (strong, nonatomic) CCSearchRequest *request;

@property (strong, nonatomic) CCRefreshTableView *tableView;

@end

@implementation CCSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)setupUI
{
    [self.contentView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

#pragma mark - CCRefreshDelegate
- (void)onHeaderRefresh
{
    
}

- (void)onFooterRefresh
{
    
}

#pragma mark - CCRequestDelegate
- (void)onRequestSuccess:(NSDictionary *)dict sender:(id)sender
{
    
}

- (void)onRequestFailed:(NSInteger)errorCode errorMsg:(NSString *)msg sender:(id)sender
{
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CCSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSearchIdentify];
    [cell setGameModel:self.dataList[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - getter
- (CCRefreshTableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[CCRefreshTableView alloc] init];
        [_tableView.tableView registerClass:[CCSearchTableViewCell class] forCellReuseIdentifier:kSearchIdentify];
        [_tableView setRefreshDelegate:self];
        [_tableView enableHeader:NO];
        [_tableView enableFooter:NO];
        _tableView.tableView.dataSource = self;
        _tableView.tableView.delegate = self;
    }
    return _tableView;
}

@end
