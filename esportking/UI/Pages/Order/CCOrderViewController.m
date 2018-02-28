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

@interface CCOrderViewController ()<UITableViewDataSource, UITableViewDelegate, CCRefreshDelegate, CCRequestDelegate, CCOrderTableViewCellDelegate, ZJScrollPageViewChildVcDelegate>

@property (strong, nonatomic) CCRefreshTableView *tableView;

@property (assign, nonatomic) ORDERTYPE orderType;
@property (strong, nonatomic) CCOrderRequest *request;
@property (strong, nonatomic) NSMutableArray<NSDictionary *> *orderList;

@end

@implementation CCOrderViewController

- (instancetype)initWithOrderType:(ORDERTYPE)type
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
        self.request.type = self.orderList;
        [self.request startPostRequestWithDelegate:self];
    }
}

- (void)onFooterRefresh
{
    
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
    self.request = nil;
    
    self.orderList = dict[@"data"];
    [self.tableView reloadData];
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
