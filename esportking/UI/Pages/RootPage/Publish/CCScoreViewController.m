//
//  CCScoreViewController.m
//  esportking
//
//  Created by CKQ on 2018/2/4.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCScoreViewController.h"
#import "CCRefreshTableView.h"

#import "CCScoreBannerTableViewCell.h"
#import "CCScoreStyleTableViewCell.h"
#import "CCTitleTableViewCell.h"
#import "CCConfirmTableViewCell.h"
#import "CCDevideTableViewCell.h"

#define kFirstIdentify       @"first"
#define kSecondIdentify      @"second"
#define kThirdIdentify       @"third"
#define kForthIdentify       @"forth"
#define kFivthIdentify       @"fivth"

#define kSystemTag           11
#define kLocationTag         12
#define kDanTag              13
#define kCountTag            14

@interface CCScoreViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *heightList;
@property (strong, nonatomic) CCRefreshTableView *tableView;

@end

@implementation CCScoreViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)configTopbar
{
    [self addTopbarTitle:@"上分"];
}

- (void)configContent
{
    [self setContentWithTopOffset:LMStatusBarHeight+LMTopBarHeight bottomOffset:0];
    [self.contentView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[CCTitleTableViewCell class]])
    {
        switch (cell.tag) {
            case kSystemTag:
            {
                
            }
                break;
            case kLocationTag:
            {
                
            }
                break;
            case kDanTag:
            {
                
            }
                break;
            case kCountTag:
            {
                
            }
                break;
            default:
                break;
        }
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.heightList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CCPXToPoint([self.heightList[indexPath.row] integerValue]);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.row == 0)
    {
        CCScoreBannerTableViewCell *tableCell = [tableView dequeueReusableCellWithIdentifier:kFirstIdentify];
        cell = tableCell;
    }
    else if (indexPath.row == 1)
    {
        CCDevideTableViewCell *tableCell = [tableView dequeueReusableCellWithIdentifier:kFivthIdentify];
        [tableCell setContentText:@"选择区服"];
        cell = tableCell;
    }
    else if (indexPath.row == 2)
    {
        CCScoreStyleTableViewCell *tableCell = [tableView dequeueReusableCellWithIdentifier:kSecondIdentify];
        cell = tableCell;
    }
    else if (indexPath.row == 3)
    {
        CCDevideTableViewCell *tableCell = [tableView dequeueReusableCellWithIdentifier:kFivthIdentify];
        [tableCell setContentText:@"说明："];
        cell = tableCell;
    }
    else if (indexPath.row == 9)
    {
        CCConfirmTableViewCell *tableCell = [tableView dequeueReusableCellWithIdentifier:kForthIdentify];
        [tableCell setPrice:0 andDelegate:self];
        cell = tableCell;
    }
    else if (indexPath.row == 8 || indexPath.row == 10)
    {
        CCDevideTableViewCell *tableCell = [tableView dequeueReusableCellWithIdentifier:kFivthIdentify];
        cell = tableCell;
    }
    else if (indexPath.row == 4)
    {
        CCTitleTableViewCell *tableCell = [tableView dequeueReusableCellWithIdentifier:kThirdIdentify];
        [tableCell setTitle:@"选择系统" subTitle:@"请选择" subTitleColor:FontColor_Gray];
        tableCell.tag = kSystemTag;
        cell = tableCell;
    }
    else if (indexPath.row == 5)
    {
        CCTitleTableViewCell *tableCell = [tableView dequeueReusableCellWithIdentifier:kThirdIdentify];
        [tableCell setTitle:@"选择区服" subTitle:@"请选择" subTitleColor:FontColor_Gray];
        tableCell.tag = kLocationTag;
        cell = tableCell;
    }
    else if (indexPath.row == 6)
    {
        CCTitleTableViewCell *tableCell = [tableView dequeueReusableCellWithIdentifier:kThirdIdentify];
        [tableCell setTitle:@"选择段位" subTitle:@"请选择" subTitleColor:FontColor_Gray];
        tableCell.tag = kDanTag;
        cell = tableCell;
    }
    else if (indexPath.row == 7)
    {
        CCTitleTableViewCell *tableCell = [tableView dequeueReusableCellWithIdentifier:kThirdIdentify];
        [tableCell setTitle:@"选择局数" subTitle:@"请选择" subTitleColor:FontColor_Gray];
        tableCell.tag = kCountTag;
        cell = tableCell;
    }
    
    return cell;
}

#pragma mark - getter
- (NSArray *)heightList
{
    if (!_heightList)
    {
        _heightList = @[@(300), @(64), @(108), @(108), @(96), @(96), @(96), @(96), @(16), @(96), @(16)];
    }
    return _heightList;
}

- (CCRefreshTableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[CCRefreshTableView alloc] initWithFrame:self.view.bounds];
        [_tableView enableHeader:NO];
        [_tableView enableFooter:NO];
        [_tableView.tableView setDataSource:self];
        [_tableView.tableView setDelegate:self];
        [_tableView.tableView setBackgroundColor:BgColor_Gray];
        [_tableView.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_tableView.tableView registerClass:[CCScoreBannerTableViewCell class] forCellReuseIdentifier:kFirstIdentify];
        [_tableView.tableView registerClass:[CCScoreStyleTableViewCell class] forCellReuseIdentifier:kSecondIdentify];
        [_tableView.tableView registerClass:[CCTitleTableViewCell class] forCellReuseIdentifier:kThirdIdentify];
        [_tableView.tableView registerClass:[CCConfirmTableViewCell class] forCellReuseIdentifier:kForthIdentify];
        [_tableView.tableView registerClass:[CCDevideTableViewCell class] forCellReuseIdentifier:kFivthIdentify];
    }
    return _tableView;
}

@end

