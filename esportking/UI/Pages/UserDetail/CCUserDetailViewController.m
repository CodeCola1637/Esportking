//
//  CCUserDetailViewController.m
//  esportking
//
//  Created by CKQ on 2018/2/25.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCUserDetailViewController.h"
#import "CCUserDetailRequest.h"
#import "CCCommentModel.h"
#import "CCTagModel.h"

#import "CCRefreshTableView.h"
#import "CCUserInfoTableViewCell.h"
#import "CCUserPriceTableViewCell.h"
#import "CCUserTagTableViewCell.h"
#import "CCUserCommentTableViewCell.h"
#import "CCSessionViewController.h"
#import "CCScoreViewController.h"

#define kFirstIdentify      @"first"
#define kSecondIdentify     @"second"
#define kThirdOneIdentify   @"third_one"
#define kThirdTwoIdentify   @"third_two"

@interface CCUserDetailViewController ()<CCRequestDelegate, CCRefreshDelegate, UITableViewDataSource, UITableViewDelegate>

@property (assign, nonatomic) uint64_t userID;
@property (assign, nonatomic) uint64_t gameID;
@property (assign, nonatomic) uint64_t userGameID;

@property (strong, nonatomic) CCUserDetailRequest *request;
@property (strong, nonatomic) CCGameModel *gameModel;
@property (strong, nonatomic) NSArray<CCCommentModel *> *commentList;
@property (strong, nonatomic) NSArray<CCTagModel *> *tagList;

@property (strong, nonatomic) CCRefreshTableView *tableView;
@property (strong, nonatomic) UIButton *msgButton;
@property (strong, nonatomic) UIButton *orderButton;

@end

@implementation CCUserDetailViewController

- (instancetype)initWithUserID:(uint64_t)userID gameID:(uint64_t)gameID userGameID:(uint64_t)userGameID
{
    if (self = [super init])
    {
        _userID = userID;
        _gameID = gameID;
        _userGameID = userGameID;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configTopBar];
    [self configContent];
    [self.tableView beginHeaderRefreshing];
}

- (void)configTopBar
{
    [self.topbarView setBackgroundColor:BgColor_Clear];
    [self addTopPopBackButton];
    [self.view bringSubviewToFront:self.topbarView];
}

- (void)configContent
{
    [self setContentWithTopOffset:-LMStatusBarHeight bottomOffset:0];
    
    [self.contentView addSubview:self.tableView];
    [self.contentView addSubview:self.msgButton];
    [self.contentView addSubview:self.orderButton];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.msgButton.mas_top);
    }];
    
    [self.msgButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(CCPXToPoint(88));
        make.width.mas_equalTo(LM_ABSOLUTE_SCREEN_WIDTH/3.f);
    }];
    [self.orderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.contentView);
        make.left.equalTo(self.msgButton.mas_right);
        make.height.mas_equalTo(CCPXToPoint(88));
    }];
}

#pragma mark - action
- (void)onClickMsgButton:(UIButton *)button
{
    NIMSession *session = [NIMSession session:[NSString stringWithFormat:@"test_%llu", self.userID] type:NIMSessionTypeP2P];
    CCSessionViewController *vc = [[CCSessionViewController alloc] initWithSession:session title:self.gameModel.userModel.name];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)onClickOrderButton:(UIButton *)button
{
    CCEvaluateUserModel *userModel = [[CCEvaluateUserModel alloc] initWithUserModel:self.gameModel.userModel];
    userModel.orderCount = self.gameModel.totalCount;
    userModel.starCount = self.gameModel.auth;
    CCScoreViewController *vc = [[CCScoreViewController alloc] initWithEvaluateUser:userModel];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - CCRefreshDelegate
- (void)onHeaderRefresh
{
    if (_request)
    {
        return;
    }
    _request = [CCUserDetailRequest new];
    _request.userID = self.userID;
    _request.gameID = self.gameID;
    _request.userGameID = self.userGameID;
    [_request startPostRequestWithDelegate:self];
}

- (void)onFooterRefresh {}

#pragma mark - CCRequestDelegate
- (void)onRequestSuccess:(NSDictionary *)dict sender:(id)sender
{
    if (sender != _request)
    {
        return;
    }
    _request = nil;
    
    self.gameModel = [CCGameModel new];
    [self.gameModel setGameInfo:dict[@"data"][@"user"]];
    
    NSArray *cmList = dict[@"data"][@"comments"];
    NSMutableArray *array = [NSMutableArray new];
    for (int i=0; i<cmList.count; i++)
    {
        [array addObject:[[CCCommentModel alloc] initWithComment:cmList[i]]];
    }
    self.commentList = array;
    
    NSArray *tgList = dict[@"data"][@"tags"];
    NSMutableArray *tagArray = [NSMutableArray new];
    for (int i=0; i<tgList.count; i++)
    {
        [tagArray addObject:[[CCTagModel alloc] initWithTagDict:tgList[i]]];
    }
    self.tagList = tagArray;
    
    [self.tableView endRefresh];
    [self.tableView reloadData];
}

- (void)onRequestFailed:(NSInteger)errorCode errorMsg:(NSString *)msg sender:(id)sender
{
    if (sender != _request)
    {
        return;
    }
    _request = nil;
    [self.tableView endRefresh];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2)
    {
        return self.commentList.count+1;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CCPXToPoint(16);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    if (indexPath.section == 2)
    {
        if (indexPath.row == 0)
        {
            height = CCPXToPoint(306);
        }
        else
        {
            height = [CCUserCommentTableViewCell heightWithComment:self.commentList[indexPath.row-1]];
        }
    }
    else if (indexPath.section == 1)
    {
        height = CCPXToPoint(306);
    }
    else if (indexPath.section == 0)
    {
        height = CCPXToPoint(696+188);
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.section == 2)
    {
        if (indexPath.row == 0)
        {
            CCUserTagTableViewCell *userCell = [tableView dequeueReusableCellWithIdentifier:kThirdOneIdentify];
            [userCell setTagList:self.tagList];
            cell = userCell;
        }
        else
        {
            CCUserCommentTableViewCell *userCell = [tableView dequeueReusableCellWithIdentifier:kThirdTwoIdentify];
            [userCell setCommentModel:self.commentList[indexPath.row-1]];
            cell = userCell;
        }
    }
    else if (indexPath.section == 1)
    {
        CCUserPriceTableViewCell *userCell = [tableView dequeueReusableCellWithIdentifier:kSecondIdentify];
        cell = userCell;
    }
    else if (indexPath.section == 0)
    {
        CCUserInfoTableViewCell *userCell = [tableView dequeueReusableCellWithIdentifier:kFirstIdentify];
        [userCell setGameModel:self.gameModel];
        cell = userCell;
    }
    return cell;
}

#pragma mark - getters
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
        [_tableView.tableView registerClass:[CCUserInfoTableViewCell class] forCellReuseIdentifier:kFirstIdentify];
        [_tableView.tableView registerClass:[CCUserPriceTableViewCell class] forCellReuseIdentifier:kSecondIdentify];
        [_tableView.tableView registerClass:[CCUserTagTableViewCell class] forCellReuseIdentifier:kThirdOneIdentify];
        [_tableView.tableView registerClass:[CCUserCommentTableViewCell class] forCellReuseIdentifier:kThirdTwoIdentify];
    }
    return _tableView;
}

- (UIButton *)msgButton
{
    if (!_msgButton)
    {
        _msgButton = [UIButton new];
        [_msgButton.layer setBorderColor:BgColor_Gray.CGColor];
        [_msgButton.layer setBorderWidth:1.f];
        [_orderButton setBackgroundColor:BgColor_White];
        [_msgButton setTitle:@"私信" forState:UIControlStateNormal];
        [_msgButton setTitleColor:BgColor_Black forState:UIControlStateNormal];
        [_msgButton addTarget:self action:@selector(onClickMsgButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _msgButton;
}

- (UIButton *)orderButton
{
    if (!_orderButton)
    {
        _orderButton = [UIButton new];
        [_orderButton setBackgroundColor:BgColor_Yellow];
        [_orderButton setTitle:@"下单" forState:UIControlStateNormal];
        [_orderButton setTitleColor:BgColor_Black forState:UIControlStateNormal];
        [_orderButton addTarget:self action:@selector(onClickOrderButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _orderButton;
}

@end
