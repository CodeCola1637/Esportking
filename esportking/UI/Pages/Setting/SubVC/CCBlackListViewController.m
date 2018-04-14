//
//  CCBlackListViewController.m
//  esportking
//
//  Created by jaycechen on 2018/3/16.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCBlackListViewController.h"
#import "CCBlackUserTableViewCell.h"
#import "CCRefreshTableView.h"

#import "CCGetBlackListRequest.h"
#import "CCDeleteBlackUserRequest.h"

#define kBlackIdentify  @"black_identify"

@interface CCBlackListViewController ()<UITableViewDelegate, UITableViewDataSource, CCRefreshDelegate, CCRequestDelegate>

@property (assign, nonatomic) uint32_t currentIndex;
@property (strong, nonatomic) CCBaseRequest *request;
@property (strong, nonatomic) NSMutableArray<CCUserModel *> *userList;

@property (strong, nonatomic) CCRefreshTableView *tableView;

@end

@implementation CCBlackListViewController

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
    [self addTopbarTitle:@"黑名单"];
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
    if (self.request)
    {
        return;
    }
    
    CCGetBlackListRequest *req = [CCGetBlackListRequest new];
    req.pageIndex = 1;
    [req startPostRequestWithDelegate:self];
    self.request = req;
}

- (void)onFooterRefresh
{
    if (self.request)
    {
        return;
    }
    
    CCGetBlackListRequest *req = [CCGetBlackListRequest new];
    req.pageIndex = self.currentIndex+1;
    [req startPostRequestWithDelegate:self];
    self.request = req;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.userList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CCPXToPoint(144);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CCBlackUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kBlackIdentify];
    [cell setUserModel:self.userList[indexPath.row]];
    return cell;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle ==UITableViewCellEditingStyleDelete)
    {
        CCUserModel *userModel = self.userList[indexPath.row];
        CCDeleteBlackUserRequest *req = [CCDeleteBlackUserRequest new];
        req.userID = userModel.userID;
        req.context = userModel;
        [req startPostRequestWithDelegate:self];
        self.request = req;
        [self beginLoading];
    }
}
#pragma mark - CCRequestDelegate
- (void)onRequestSuccess:(NSDictionary *)dict sender:(id)sender
{
    if (sender != self.request)
    {
        return;
    }
    self.request = nil;
    if ([sender isKindOfClass:[CCGetBlackListRequest class]])
    {
        CCGetBlackListRequest *req = sender;
        if (req.pageIndex == 1)
        {
            self.userList = [NSMutableArray arrayWithArray:req.userList];
        }
        else
        {
            [self.userList addObjectsFromArray:req.userList];
        }
        self.currentIndex = req.pageIndex;
        [self.tableView reloadData];
    }
    else if ([sender isKindOfClass:[CCDeleteBlackUserRequest class]])
    {
        CCDeleteBlackUserRequest *req = sender;
        [self.userList removeObject:req.context];
        [self.tableView reloadData];
        [self endLoading];
    }
}

- (void)onRequestFailed:(NSInteger)errorCode errorMsg:(NSString *)msg sender:(id)sender
{
    if (sender != self.request)
    {
        return;
    }
    self.request = nil;
    [self.tableView reloadData];
    [self endLoading];
    [self showToast:msg];
}

#pragma mark - getter
- (CCRefreshTableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[CCRefreshTableView alloc] init];
        [_tableView.tableView registerClass:[CCBlackUserTableViewCell class] forCellReuseIdentifier:kBlackIdentify];
        [_tableView setRefreshDelegate:self];
        [_tableView enableHeader:YES];
        [_tableView enableFooter:NO];
        _tableView.tableView.dataSource = self;
        _tableView.tableView.delegate = self;
    }
    return _tableView;
}

@end
