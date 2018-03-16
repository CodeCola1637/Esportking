//
//  CCScoreViewController.m
//  esportking
//
//  Created by CKQ on 2018/2/4.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCScoreViewController.h"
#import "CCPayViewController.h"

#import "CCScoreModel.h"

#import "CCRefreshTableView.h"
#import "CCPickerView.h"
#import "CCDanPickerView.h"
#import "CCScoreBannerTableViewCell.h"
#import "CCScoreStyleTableViewCell.h"
#import "CCTitleTableViewCell.h"
#import "CCConfirmTableViewCell.h"
#import "CCDevideTableViewCell.h"

#import <zhPopupController.h>

#define kFirstIdentify       @"first"
#define kSecondIdentify      @"second"
#define kThirdIdentify       @"third"
#define kForthIdentify       @"forth"
#define kFivthIdentify       @"fivth"

#define kSystemTag           11
#define kLocationTag         12
#define kDanTag              13
#define kCountTag            14
#define kStartDanTag         15
#define kEndDanTag           16

@interface CCScoreViewController ()<UITableViewDataSource, UITableViewDelegate, CCConfirmTableViewCellDelegate, CCScoreStyleTableViewCellDelegate>

@property (strong, nonatomic) CCEvaluateUserModel *userModel;
@property (strong, nonatomic) CCScoreModel *scoreModel;

@property (strong, nonatomic) NSArray *heightList;
@property (strong, nonatomic) CCRefreshTableView *tableView;

@end

@implementation CCScoreViewController

- (instancetype)initWithEvaluateUser:(CCEvaluateUserModel *)user
{
    if (self = [super init])
    {
        self.userModel = user;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scoreModel = [CCScoreModel new];
    self.scoreModel.style = SCORESTYLE_SCORE;
    
    [self configTopbar];
    [self configContent];
}

- (void)configTopbar
{
    if (self.userModel)
    {
        [self addTopPopBackButton];
        [self addTopbarTitle:@"下单"];
    }
    else
    {
        [self addTopbarTitle:@"上分"];
    }
}

- (void)configContent
{
    [self setContentWithTopOffset:LMStatusBarHeight+LMTopBarHeight bottomOffset:0];
    [self.contentView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

#pragma mark - CCScoreStyleTableViewCellDelegate
- (void)didSelectScoreStyle:(SCORESTYLE)style
{
    if (self.scoreModel.style != style)
    {
        self.scoreModel.style = style;
        [self.tableView reloadData];
    }
}

#pragma mark - CCConfirmTableViewCellDelegate
- (void)onSelectOrder
{
    if ([self.scoreModel checkInfoCompleted])
    {
        CCPayViewController *vc = [[CCPayViewController alloc] initWithScoreModel:self.scoreModel receiverID:self.userModel.userID];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO];
    
    if ([cell isKindOfClass:[CCTitleTableViewCell class]])
    {
        UIView *pickerView = nil;
        CCWeakSelf(weakSelf);
        
        switch (cell.tag) {
            case kSystemTag:
            {
                pickerView = [[CCPickerView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 275)  data:@[Wording_System_iOS, Wording_System_Andorid] saveBlock:^(NSString *content, NSInteger selectIndex) {
                    
                    weakSelf.scoreModel.system = selectIndex;
                    [weakSelf.tableView reloadData];
                    [weakSelf.zh_popupController dismiss];
                } cancelBlock:^{
                    [weakSelf.zh_popupController dismiss];
                }];
            }
                break;
            case kLocationTag:
            {
                pickerView = [[CCPickerView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 275)  data:@[Wording_Platform_QQ, Wording_Platform_WX] saveBlock:^(NSString *content, NSInteger selectIndex) {
                    
                    weakSelf.scoreModel.platform = selectIndex;
                    [weakSelf.tableView reloadData];
                    [weakSelf.zh_popupController dismiss];
                } cancelBlock:^{
                    [weakSelf.zh_popupController dismiss];
                }];
            }
                break;
            case kDanTag:
            {
                pickerView = [[CCPickerView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 275)  data:@[Wording_Dan_QingTong, Wording_Dan_BaiYin, Wording_Dan_HuangJin, Wording_Dan_BOJIN, Wording_Dan_ZuanShi, Wording_Dan_XingYao, Wording_Dan_WangZhe] saveBlock:^(NSString *content, NSInteger selectIndex) {
                    
                    weakSelf.scoreModel.level = selectIndex;
                    [weakSelf.tableView reloadData];
                    [weakSelf.zh_popupController dismiss];
                } cancelBlock:^{
                    [weakSelf.zh_popupController dismiss];
                }];
            }
                break;
            case kCountTag:
            {
                pickerView = [[CCPickerView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 275)  data:@[@"1", @"2", @"3", @"4", @"5"] saveBlock:^(NSString *content, NSInteger selectIndex) {
                    
                    weakSelf.scoreModel.count = (uint32_t)selectIndex;
                    [weakSelf.tableView reloadData];
                    [weakSelf.zh_popupController dismiss];
                } cancelBlock:^{
                    [weakSelf.zh_popupController dismiss];
                }];
            }
                break;
            case kStartDanTag:
            {
                pickerView = [[CCDanPickerView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 275) saveBlock:^(NSString *content, NSInteger selectIndex) {
                    
                    if (selectIndex < weakSelf.scoreModel.endLevel || weakSelf.scoreModel.endLevel == 0)
                    {
                        weakSelf.scoreModel.startLevel = (uint32_t)selectIndex;
                        [weakSelf.tableView reloadData];
                    }
                    else
                    {
                        [weakSelf showToast:@"目标段位必须大于当前段位"];
                    }
                    [weakSelf.zh_popupController dismiss];
                } cancelBlock:^{
                    [weakSelf.zh_popupController dismiss];
                }];
            }
                break;
            case kEndDanTag:
            {
                pickerView = [[CCDanPickerView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 275) saveBlock:^(NSString *content, NSInteger selectIndex) {
                    
                    if (selectIndex > weakSelf.scoreModel.startLevel)
                    {
                        weakSelf.scoreModel.endLevel = (uint32_t)selectIndex;
                        [weakSelf.tableView reloadData];
                    }
                    else
                    {
                        [weakSelf showToast:@"目标段位必须大于当前段位"];
                    }
                    [weakSelf.zh_popupController dismiss];
                } cancelBlock:^{
                    [weakSelf.zh_popupController dismiss];
                }];
            }
                break;
            default:
                break;
        }
        
        if (pickerView)
        {
            self.zh_popupController = [zhPopupController new];
            self.zh_popupController.layoutType = zhPopupLayoutTypeBottom;
            self.zh_popupController.dismissOnMaskTouched = NO;
            [self.zh_popupController presentContentView:pickerView];
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
    if (indexPath.row == 0 && self.userModel)
    {
        return CCPXToPoint([self.heightList[indexPath.row] integerValue]+88);
    }
    return CCPXToPoint([self.heightList[indexPath.row] integerValue]);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.row == 0)
    {
        CCScoreBannerTableViewCell *tableCell = [tableView dequeueReusableCellWithIdentifier:kFirstIdentify];
        [tableCell setEvaluateUserModel:self.userModel];
        cell = tableCell;
    }
    else if (indexPath.row == 1)
    {
        CCDevideTableViewCell *tableCell = [tableView dequeueReusableCellWithIdentifier:kFivthIdentify];
        [tableCell setContentText:@"选择您想要的服务"];
        [tableCell setBackgroundColor:BgColor_SuperLightGray];
        cell = tableCell;
    }
    else if (indexPath.row == 2)
    {
        CCScoreStyleTableViewCell *tableCell = [tableView dequeueReusableCellWithIdentifier:kSecondIdentify];
        [tableCell setDelegate:self];
        cell = tableCell;
    }
    else if (indexPath.row == 3)
    {
        CCDevideTableViewCell *tableCell = [tableView dequeueReusableCellWithIdentifier:kFivthIdentify];
        [tableCell setContentText:@"说明：娱乐专车是有大神带你开黑，以娱乐为主，不一定100%胜率，想要上分的小伙伴建议乘坐上分专车。"];
        [tableCell setBackgroundColor:BgColor_SuperLightGray];
        cell = tableCell;
    }
    else if (indexPath.row == 9)
    {
        CCConfirmTableViewCell *tableCell = [tableView dequeueReusableCellWithIdentifier:kForthIdentify];
        [tableCell setPrice:0 andDelegate:nil];
        [self.scoreModel calCulateMoney:^(BOOL success, uint32_t money) {
            [tableCell setPrice:money andDelegate:self];
        }];
        cell = tableCell;
    }
    else if (indexPath.row == 8)
    {
        CCDevideTableViewCell *tableCell = [tableView dequeueReusableCellWithIdentifier:kFivthIdentify];
        [tableCell setBackgroundColor:FontColor_SuperLightGray];
        cell = tableCell;
    }
    else if (indexPath.row == 4)
    {
        CCTitleTableViewCell *tableCell = [tableView dequeueReusableCellWithIdentifier:kThirdIdentify];
        NSString *system = [CCScoreModel getSystemStr:self.scoreModel.system];
        [tableCell setTitle:@"选择系统" subTitle:(system?:@"请选择") subTitleColor:(system?FontColor_Black:FontColor_Gray)];
        tableCell.tag = kSystemTag;
        cell = tableCell;
    }
    else if (indexPath.row == 5)
    {
        CCTitleTableViewCell *tableCell = [tableView dequeueReusableCellWithIdentifier:kThirdIdentify];
        NSString *platform = [CCScoreModel getPlatformStr:self.scoreModel.platform];
        [tableCell setTitle:@"选择区服" subTitle:(platform?:@"请选择") subTitleColor:(platform?FontColor_Black:FontColor_Gray)];
        tableCell.tag = kLocationTag;
        cell = tableCell;
    }
    else if (indexPath.row == 6)
    {
        CCTitleTableViewCell *tableCell = [tableView dequeueReusableCellWithIdentifier:kThirdIdentify];
        if (SCORESTYLE_SCORE == self.scoreModel.style)
        {
            NSString *startLevel = [CCScoreModel getDetailLevelStr:self.scoreModel.startLevel];
            [tableCell setTitle:@"当前段位" subTitle:(startLevel?:@"请选择") subTitleColor:(startLevel?FontColor_Black:FontColor_Gray)];
            tableCell.tag = kStartDanTag;
        }
        else
        {
            NSString *level = [CCScoreModel getLevelStr:self.scoreModel.level];
            [tableCell setTitle:@"选择段位" subTitle:(level?:@"请选择") subTitleColor:(level?FontColor_Black:FontColor_Gray)];
            tableCell.tag = kDanTag;
        }
        cell = tableCell;
    }
    else if (indexPath.row == 7)
    {
        CCTitleTableViewCell *tableCell = [tableView dequeueReusableCellWithIdentifier:kThirdIdentify];
        if (SCORESTYLE_SCORE == self.scoreModel.style)
        {
            NSString *endLevel = [CCScoreModel getDetailLevelStr:self.scoreModel.endLevel];
            [tableCell setTitle:@"目标段位" subTitle:(endLevel?:@"请选择") subTitleColor:(endLevel?FontColor_Black:FontColor_Gray)];
            tableCell.tag = kEndDanTag;
        }
        else
        {
            NSString *countStr = [CCScoreModel getCountStr:self.scoreModel.count];
            [tableCell setTitle:@"选择局数" subTitle:(countStr?:@"请选择") subTitleColor:(countStr?FontColor_Black:FontColor_Gray)];
            tableCell.tag = kCountTag;
        }
        cell = tableCell;
    }
    
    return cell;
}

#pragma mark - getter
- (NSArray *)heightList
{
    if (!_heightList)
    {
        _heightList = @[@(300), @(64), @(108), @(108), @(96), @(96), @(96), @(96), @(16), @(96)];
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
        [_tableView.tableView setBounces:NO];
        [_tableView.tableView setBackgroundColor:FontColor_SuperLightGray];
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

