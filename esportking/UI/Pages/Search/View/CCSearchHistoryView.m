//
//  CCSearchHistoryView.m
//  esportking
//
//  Created by jaycechen on 2018/3/5.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCSearchHistoryView.h"
#import "CCRefreshTableView.h"
#import "CCTitleTableViewCell.h"
#import "CCDevideTableViewCell.h"
#import "CCCenterTitleTableViewCell.h"

#import "CCHistoryService.h"

#define kFirstItem      @"first"
#define kContentItem    @"content"
#define kLastItem       @"last"

@interface CCSearchHistoryView ()<UITableViewDelegate, UITableViewDataSource>

@property (weak  , nonatomic) id<CCSearchHistoryViewDelegate> delegate;
@property (strong, nonatomic) UIImageView *emptyImgView;
@property (strong, nonatomic) CCRefreshTableView *tableView;
@property (strong, nonatomic) NSArray<NSString *> *historyList;

@end

@implementation CCSearchHistoryView

- (instancetype)initWithDelegate:(id<CCSearchHistoryViewDelegate>)del
{
    if (self = [super init])
    {
        _delegate = del;
        _historyList = [CCHistoryServiceInstance getSearchHistory];
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    [self addSubview:self.emptyImgView];
    [self addSubview:self.tableView];
    [self.emptyImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    if (self.historyList.count == 0)
    {
        [self.tableView setHidden:YES];
    }
    else
    {
        [self.emptyImgView setHidden:YES];
    }
}

- (void)reloadData
{
    self.historyList = [CCHistoryServiceInstance getSearchHistory];
    if (self.historyList.count == 0)
    {
        [self.tableView setHidden:YES];
        [self.emptyImgView setHidden:NO];
    }
    else
    {
        [self.emptyImgView setHidden:YES];
        [self.tableView setHidden:NO];
        [self.tableView reloadData];
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[CCCenterTitleTableViewCell class]])
    {
        [CCHistoryServiceInstance clearSearchHistory];
        [self reloadData];
    }
    else
    {
        NSString *history = self.historyList[indexPath.row-1];
        [self.delegate didSelectSearchHistory:history];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.historyList.count+2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return CCPXToPoint(64);
    }
    else
    {
        return CCPXToPoint(96);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.row == 0)
    {
        CCDevideTableViewCell *tableCell = [tableView dequeueReusableCellWithIdentifier:kFirstItem];
        [tableCell setContentText:@"搜索历史"];
        cell = tableCell;
    }
    else if (indexPath.row == self.historyList.count+1)
    {
        CCCenterTitleTableViewCell *tableCell = [tableView dequeueReusableCellWithIdentifier:kLastItem];
        [tableCell setTitle:@"清空历史记录"];
        [tableCell.lineView setHidden:YES];
        cell = tableCell;
    }
    else
    {
        CCTitleTableViewCell *tableCell = [tableView dequeueReusableCellWithIdentifier:kContentItem];
        [tableCell setTitle:self.historyList[indexPath.row-1] subTitle:nil subTitleColor:nil];
        [tableCell enableArrow:NO];
        cell = tableCell;
    }
    return cell;
}

#pragma mark - getter
- (UIImageView *)emptyImgView
{
    if (!_emptyImgView)
    {
        _emptyImgView = [UIImageView scaleFillImageView];
        [_emptyImgView setImage:CCIMG(@"Placeholder_Icon")];
    }
    return _emptyImgView;
}

- (CCRefreshTableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[CCRefreshTableView alloc] init];
        [_tableView.tableView registerClass:[CCDevideTableViewCell class] forCellReuseIdentifier:kFirstItem];
        [_tableView.tableView registerClass:[CCTitleTableViewCell class] forCellReuseIdentifier:kContentItem];
        [_tableView.tableView registerClass:[CCCenterTitleTableViewCell class] forCellReuseIdentifier:kLastItem];
        [_tableView enableHeader:NO];
        [_tableView enableFooter:NO];
        _tableView.tableView.dataSource = self;
        _tableView.tableView.delegate = self;
    }
    return _tableView;
}

@end
