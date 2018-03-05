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
#import "LMSearchBarView.h"
#import "CCUserDetailViewController.h"

#import "CCSearchRequest.h"

#define kSearchIdentify @"search"

@interface CCSearchViewController ()<UITableViewDelegate, UITableViewDataSource, CCRefreshDelegate, CCRequestDelegate, LMSearchBarDelegate>

@property (strong, nonatomic) NSMutableArray<CCGameModel *> *dataList;
@property (strong, nonatomic) CCSearchRequest *request;

@property (strong, nonatomic) LMSearchBarView *searchBarView;
@property (strong, nonatomic) CCRefreshTableView *tableView;

@end

@implementation CCSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configTopbar];
    [self configContent];
}

- (void)configTopbar
{
    [self.topbarView addSubview:self.searchBarView];
    [self.searchBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.and.right.equalTo(self.searchBarView).with.insets(UIEdgeInsetsZero);
        make.top.equalTo(self.searchBarView).with.offset(LMStatusBarHeight);
    }];
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
    
}

- (void)onFooterRefresh
{
    
}

#pragma mark - LMSearchBarDelegate
- (void)onSearch:(NSString *)keywords
{
    if (keywords && keywords.length>0)
    {
        self.request = [[CCSearchRequest alloc] init];
        self.request.gameID = GAMEID_WANGZHE;
        self.request.keywords = keywords;
        [self.request startPostRequestWithDelegate:self];
    }
    else
    {
        // 进入搜索历史页面
    }
}

- (void)onCancelSearch
{
    //修改push方向
    CATransition* transition = [CATransition animation];
    transition.type          = kCATransitionReveal;//可更改为其他方式
    transition.subtype       = kCATransitionFromBottom;//可更改为其他方式
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController popToRootViewControllerAnimated:NO];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CCGameModel *model = self.dataList[indexPath.row];
    CCUserDetailViewController *vc = [[CCUserDetailViewController alloc] initWithUserID:model.userModel.userID gameID:model.gameID userGameID:model.userGameID];
    [self.navigationController pushViewController:vc animated:YES];
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

#pragma mark - CCRequestDelegate
- (void)onRequestSuccess:(NSDictionary *)dict sender:(id)sender
{
    if (sender != self.request)
    {
        return;
    }
    self.request = nil;
    
    NSArray *data = dict[@"data"];
    self.dataList = [NSMutableArray new];
    for (int i=0; i<data.count; i++)
    {
        CCGameModel *model = [CCGameModel new];
        [model setGameInfo:data[i]];
        [self.dataList addObject:model];
    }
    
    [self.tableView reloadData];
    [self endLoading];
}

- (void)onRequestFailed:(NSInteger)errorCode errorMsg:(NSString *)msg sender:(id)sender
{
    if (sender != self.request)
    {
        return;
    }
    self.request = nil;
    
    [self showToast:msg];
    [self endLoading];
}

#pragma mark - getter
- (LMSearchBarView *)searchBarView
{
    if (!_searchBarView)
    {
        _searchBarView = [[LMSearchBarView alloc] initWithLeftView:nil];
        _searchBarView.delegate = self;
    }
    return _searchBarView;
}

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
