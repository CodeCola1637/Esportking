//
//  CCMoneyViewController.m
//  esportking
//
//  Created by jaycechen on 2018/2/28.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCMoneyViewController.h"
#import "CCRefreshTableView.h"
#import "CCMoneyTableViewCell.h"
#import "ZJScrollPageViewDelegate.h"

#import "CCMoneyRequest.h"

#define kIdentify   @"identify"

@interface CCMoneyViewController ()<UITableViewDataSource, UITableViewDelegate, CCRefreshDelegate, CCRequestDelegate, ZJScrollPageViewChildVcDelegate>

@property (strong, nonatomic) CCRefreshTableView *tableView;

@property (assign, nonatomic) MONEYTYPE moneyType;
@property (strong, nonatomic) CCMoneyRequest *request;
@property (strong, nonatomic) NSMutableArray<NSDictionary *> *moneyList;

@end

@implementation CCMoneyViewController

- (instancetype)initWithMoneyType:(MONEYTYPE)type
{
    if (self = [super init])
    {
        self.moneyType = type;
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
        self.request = [CCMoneyRequest new];
        self.request.type = self.moneyType;
        [self.request startPostRequestWithDelegate:self];
    }
}

- (void)onFooterRefresh
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
    
    self.moneyList = dict[@"data"];
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
    return self.moneyList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CCPXToPoint(200);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CCMoneyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kIdentify];
    [cell setMoneyDict:self.moneyList[indexPath.row]];
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
        [_tableView.tableView registerClass:[CCMoneyTableViewCell class] forCellReuseIdentifier:kIdentify];
    }
    return _tableView;
}
