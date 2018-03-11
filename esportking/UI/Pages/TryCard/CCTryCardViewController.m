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

#import "CCAddTryCardRequest.h"
#import "CCGetTryCardRequest.h"

#import <TKAlert&TKActionSheet/TKAlert&TKActionSheet.h>

#define kIdentify   @"identify"
#define kPageSize   10

@interface CCTryCardViewController ()<UITableViewDataSource, UITableViewDelegate, CCRefreshDelegate, CCRequestDelegate>

@property (strong, nonatomic) CCRefreshTableView *tableView;

@property (assign, nonatomic) uint32_t pageIndex;
@property (strong, nonatomic) CCGetTryCardRequest *getReq;
@property (strong, nonatomic) CCAddTryCardRequest *addReq;
@property (strong, nonatomic) NSMutableArray<CCTryCardModel *> *cardList;

@end

@implementation CCTryCardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configTopbar];
    [self configContent];
    [self.tableView beginHeaderRefreshing];
}

- (void)configTopbar
{
    [self addTopPopBackButton];
    [self addTopbarTitle:@"体验卡"];
    UIButton *button = [UIButton new];
    [button setTitle:@"添加" forState:UIControlStateNormal];
    [button.titleLabel setFont:Font_Middle];
    [button setTitleColor:BgColor_Black forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onClickAddButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.topbarView layoutRightControls:@[button] spacing:nil];
}

- (void)configContent
{
    [self setContentWithTopOffset:LMStatusBarHeight+LMTopBarHeight bottomOffset:LMLayoutAreaBottomHeight];
    
    [self.contentView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

#pragma mark - Action
- (void)onClickAddButton:(UIButton *)button
{
    TKTextFieldAlertViewController *textFieldAlertView = [[TKTextFieldAlertViewController alloc] initWithTitle:@"昵称" placeholder:@"请输入昵称"];
    
    CCWeakSelf(weakSelf);
    __weak typeof(textFieldAlertView) weakAlertView = textFieldAlertView;
    [textFieldAlertView addButtonWithTitle:@"取消" block:^(NSUInteger index) {
        
    }];
    [textFieldAlertView addButtonWithTitle:@"确定"  block:^(NSUInteger index) {
        [weakSelf addTryCard:weakAlertView.textField.text];
    }];
    [textFieldAlertView show];
}

- (void)addTryCard:(NSString *)cardID
{
    if (cardID && cardID.length>0)
    {
        [self beginLoading];
        self.addReq = [CCAddTryCardRequest new];
        self.addReq.cardID = cardID;
        [self.addReq startPostRequestWithDelegate:self];
    }
}

#pragma mark - CCRefreshDelegate
- (void)onHeaderRefresh
{
    if (!self.getReq || self.getReq.pageIndex!=1)
    {
        self.getReq = [CCGetTryCardRequest new];
        self.getReq.pageIndex = 1;
        self.getReq.pageNumber = kPageSize;
        [self.getReq startPostRequestWithDelegate:self];
    }
}

- (void)onFooterRefresh
{
    if (!self.getReq)
    {
        self.getReq = [CCGetTryCardRequest new];
        self.getReq.pageIndex = _pageIndex+1;
        self.getReq.pageNumber = kPageSize;
        [self.getReq startPostRequestWithDelegate:self];
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - CCRequestDelegate
- (void)onRequestSuccess:(NSDictionary *)dict sender:(id)sender
{
    if (sender == self.getReq)
    {
        _pageIndex = self.getReq.pageIndex;
        if (_pageIndex == 1)
        {
            self.cardList = self.getReq.cardList;
        }
        else
        {
            [self.cardList addObjectsFromArray:self.getReq.cardList];
        }
        
        [self.tableView reloadData];
        self.getReq = nil;
    }
    
    if ([sender isKindOfClass:[CCAddTryCardRequest class]])
    {
        self.addReq = nil;
        self.getReq = nil;
        [self endLoading];
        [self.tableView beginHeaderRefreshing];
    }
}

- (void)onRequestFailed:(NSInteger)errorCode errorMsg:(NSString *)msg sender:(id)sender
{
    if (sender == self.getReq)
    {
        self.getReq = nil;
    }
    if (sender == self.addReq)
    {
        self.addReq = nil;
    }
    
    [self endLoading];
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
    [cell setTryCardModel:self.cardList[indexPath.row]];
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
        [_tableView.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_tableView.tableView registerClass:[CCTryCardTableViewCell class] forCellReuseIdentifier:kIdentify];
    }
    return _tableView;
}

@end
