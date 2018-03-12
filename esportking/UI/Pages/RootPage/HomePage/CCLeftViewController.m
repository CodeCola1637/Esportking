//
//  CCLeftViewController.m
//  esportking
//
//  Created by CKQ on 2018/2/17.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCLeftViewController.h"
#import "CCPageContainerViewController.h"
#import "CCChangeUserInfoViewController.h"
#import "CCOrderViewController.h"
#import "CCTryCardViewController.h"

#import "CCHeadTableViewCell.h"
#import "CCImgTitleTableViewCell.h"

#import <UIViewController+CWLateralSlide.h>

typedef enum : NSUInteger {
    ITEM_USER,
    ITEM_MONEY,
    ITEM_ORDER,
    ITEM_COMEIN,
    ITEM_INVITE,
    ITEM_TRY,
    ITEM_SET
} ITEM;

#define kHeaderIndentify    @"header"
#define kItemIndentify      @"item"

@interface CCLeftViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *iconArray;
@property (strong, nonatomic) NSArray *titleArray;

@end

@implementation CCLeftViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI
{
    _iconArray = @[CCIMG(@"Money_Icon"), CCIMG(@"Order_Icon"), CCIMG(@"Comein_Icon"), CCIMG(@"Invite_Icon"), CCIMG(@"Try_Icon"), CCIMG(@"Setting_Icon")];
    _titleArray = @[@"我的钱包", @"我的订单", @"我要入驻", @"邀请码", @"体验卡", @"设置"];
    
    [self.view setFrame:CGRectMake(0, 0, LM_SCREEN_WIDTH*0.75f, LM_SCREEN_HEIGHT)];
    [self setContentWithTopOffset:0 bottomOffset:0];
    
    [self.contentView addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return CCPXToPoint(280);
    }
    else
    {
        return CCPXToPoint(100);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.row == 0)
    {
        CCHeadTableViewCell *headCell = [tableView dequeueReusableCellWithIdentifier:kHeaderIndentify];
        cell = headCell;
    }
    else
    {
        CCImgTitleTableViewCell *titleCell = [tableView dequeueReusableCellWithIdentifier:kItemIndentify];
        [titleCell setIcon:_iconArray[indexPath.row-1] andTitle:_titleArray[indexPath.row-1]];
        cell = titleCell;
    }
    cell.tag = indexPath.row;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO];
    switch (cell.tag)
    {
        case ITEM_USER:
        {
            CCChangeUserInfoViewController *vc = [[CCChangeUserInfoViewController alloc] init];
            [self cw_pushViewController:vc];
        }
            break;
        case ITEM_MONEY:
        {
            
        }
            break;
        case ITEM_ORDER:
        {
            CCOrderViewController *vc1 = [[CCOrderViewController alloc] initWithOrderType:ORDERSOURCE_SEND];
            CCOrderViewController *vc2 = [[CCOrderViewController alloc] initWithOrderType:ORDERSOURCE_RECV];
            CCPageContainerViewController *container = [[CCPageContainerViewController alloc] initWithVCs:@[vc1, vc2] subTitles:@[@"我发起的", @"我收到的"] andTitle:@"我的订单"];
            [self cw_pushViewController:container];
        }
            break;
        case ITEM_COMEIN:
        {
            
        }
            break;
        case ITEM_INVITE:
        {
            
        }
            break;
        case ITEM_TRY:
        {
            CCTryCardViewController *vc = [CCTryCardViewController new];
            [self cw_pushViewController:vc];
        }
            break;
        case ITEM_SET:
        {
            
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - getters
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width*0.75f, self.contentView.frame.size.height) style:UITableViewStylePlain];
        [_tableView registerClass:[CCHeadTableViewCell class] forCellReuseIdentifier:kHeaderIndentify];
        [_tableView registerClass:[CCImgTitleTableViewCell class] forCellReuseIdentifier:kItemIndentify];
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

@end
