//
//  CCTryCardViewController.m
//  esportking
//
//  Created by jaycechen on 2018/2/28.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCTryCardViewController.h"
#import "CCRefreshTableView.h"
#import "CCTryCardTableViewCell.h"

#import "CCTryCardRequest.h"

#define kIdentify   @"identify"

@interface CCTryCardViewController ()<UITableViewDataSource, UITableViewDelegate, CCRefreshDelegate, CCRequestDelegate>

@property (strong, nonatomic) CCRefreshTableView *tableView;

@property (strong, nonatomic) CCTryCardRequest *request;
@property (strong, nonatomic) NSMutableArray<NSDictionary *> *cardList;

@end

@implementation CCTryCardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configContent];
    [self.tableView beginHeaderRefreshing];
}

- (void)configTopbar
{
    [self addTopPopBackButton];
    [self addTopbarTitle:@"体验卡"];
}

- (void)configContent
{
    [self setContentWithTopOffset:LMStatusBarHeight+LMTopBarHeight bottomOffset:LMLayoutAreaBottomHeight];
    
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
        self.request = [CCTryCardRequest new];
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
    
    self.cardList = dict[@"data"];
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
    return self.cardList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CCPXToPoint(200);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CCTryCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kIdentify];
    [cell setTryCardDict:self.cardList[indexPath.row]];
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
        [_tableView.tableView registerClass:[CCTryCardTableViewCell class] forCellReuseIdentifier:kIdentify];
    }
    return _tableView;
}

@end
