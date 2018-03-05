//
//  CCOrderViewController.m
//  esportking
//
//  Created by jaycechen on 2018/2/28.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCOrderViewController.h"
#import "CCRefreshTableView.h"
#import "CCOrderTableViewCell.h"
#import "ZJScrollPageViewDelegate.h"
#import "CCOrderRequest.h"

#define kIdentify   @"identify"
#define kPageSize   20

@interface CCOrderViewController ()<UITableViewDataSource, UITableViewDelegate, CCRefreshDelegate, CCRequestDelegate, CCOrderTableViewCellDelegate, ZJScrollPageViewChildVcDelegate>

@property (strong, nonatomic) CCRefreshTableView *tableView;

@property (assign, nonatomic) ORDERSTATUS orderType;
@property (assign, nonatomic) uint64_t pageNum;
@property (strong, nonatomic) CCOrderRequest *request;
@property (strong, nonatomic) NSMutableArray<NSDictionary *> *orderList;

@end

@implementation CCOrderViewController

- (instancetype)initWithOrderType:(ORDERSTATUS)type
{
    if (self = [super init])
    {
        self.orderType = type;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configContent];
    [self.tableView beginHeaderRefreshing];
}

- (void)configContent
{
    [self setContentWithTopOffset:0 bottomOffset:0];
    
    [self.contentView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

#pragma mark - CCRefreshDelegate
- (void)onHeaderRefresh
{
    if (!self.request)
    {
        self.request = [CCOrderRequest new];
        self.request.type = self.orderType;
        self.request.gameID = GAMEID_WANGZHE;
        self.request.pageNum = 1;
        self.request.pageSize = kPageSize;
        [self.request startPostRequestWithDelegate:self];
    }
}

- (void)onFooterRefresh
{
    if (!self.request)
    {
        self.request = [CCOrderRequest new];
        self.request.type = self.orderType;
        self.request.gameID = GAMEID_WANGZHE;
        self.request.pageNum = self.pageNum+1;
        self.request.pageSize = kPageSize;
        [self.request startPostRequestWithDelegate:self];
    }
}

#pragma mark - CCOrderTableViewCellDelegate
- (void)onCancelOrder:(NSDictionary *)dict
{
    
}

- (void)onConfirmOrder:(NSDictionary *)dict
{
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - CCRequestDelegate
- (void)onRequestSuccess:(NSDictionary *)dict sender:(id)sender
{
    if (sender != self.request)
    {
        return;
    }
    
    if (self.request.pageNum == 1)
    {
        self.orderList = [[NSMutableArray alloc] initWithArray:dict[@"data"]];
    }
    else
    {
        [self.orderList = self.orderList addObject:dict[@"data"]];
    }
    self.pageNum = self.request.pageNum;
    
    [self.tableView reloadData];
    self.request = nil;
}

- (void)onRequestFailed:(NSInteger)errorCode errorMsg:(NSString *)msg sender:(id)sender
{
    if (sender != self.request)
    {
        return;
    }
    self.request = nil;
    
    [self.tableView endRefresh];
    [self showToast:msg];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.orderList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CCPXToPoint(200);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CCOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kIdentify];
    [cell setOrderDict:self.orderList[indexPath.row] andDelegate:self];
    return cell;
}

#pragma mark - getter
- (CCRefreshTableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[CCRefreshTableView alloc] initWithFrame:self.view.bounds];
        [_tableView enableFooter:NO];
        [_tableView setRefreshDelegate:self];
        [_tableView.tableView setDataSource:self];
        [_tableView.tableView setDelegate:self];
        [_tableView.tableView setBackgroundColor:BgColor_Gray];
        [_tableView.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_tableView.tableView registerClass:[CCOrderTableViewCell class] forCellReuseIdentifier:kIdentify];
    }
    return _tableView;
}

@end
