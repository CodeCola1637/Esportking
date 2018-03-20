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
#import "CCSearchHistoryView.h"
#import "CCHistoryService.h"

#import "CCSearchRequest.h"

#define kSearchIdentify @"search"

@interface CCSearchViewController ()<UITableViewDelegate, UITableViewDataSource, CCRefreshDelegate, CCRequestDelegate, LMSearchBarDelegate, CCSearchHistoryViewDelegate>

@property (strong, nonatomic) NSMutableArray<CCGameModel *> *dataList;
@property (strong, nonatomic) CCSearchRequest *request;

@property (strong, nonatomic) CCSearchHistoryView *historyView;
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
        make.left.bottom.right.equalTo(self.topbarView).with.insets(UIEdgeInsetsZero);
        make.top.equalTo(self.topbarView).with.offset(LMStatusBarHeight);
    }];
}

- (void)configContent
{
    [self setContentWithTopOffset:LMStatusBarHeight+LMTopBarHeight bottomOffset:LMLayoutAreaBottomHeight];
    
    [self.contentView addSubview:self.historyView];
    [self.contentView addSubview:self.tableView];
    
    [self.historyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    [self.tableView setHidden:YES];
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
        [CCHistoryServiceInstance addSearchHistory:keywords];
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
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - CCSearchHistoryViewDelegate
- (void)didSelectSearchHistory:(NSString *)words
{
    [self onSearch:words];
    [self.searchBarView.searchTextField setText:words];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CCPXToPoint(144);
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
    
    [self.historyView setHidden:YES];
    [self.tableView setHidden:NO];
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
- (CCSearchHistoryView *)historyView
{
    if (!_historyView)
    {
        _historyView = [[CCSearchHistoryView alloc] initWithDelegate:self];
    }
    return _historyView;
}

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
