//
//  CCRootViewController.m
//  esportking
//
//  Created by CKQ on 2018/2/3.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCRootViewController.h"
#import "CCHomeViewController.h"
#import "CCScoreViewController.h"
#import "CCMessageViewController.h"
#import "CCShowView.h"
#import "CCScoreWaitViewController.h"
#import "CCOrderRequest.h"

@interface CCRootViewController ()<CCShowViewDelegate, CCRequestDelegate>

@property (strong, nonatomic) CCHomeViewController      *homeController;
@property (strong, nonatomic) CCScoreViewController     *scoreController;
@property (strong, nonatomic) CCMessageViewController   *messageController;

@property (strong, nonatomic) CCOrderRequest *request;
@property (strong, nonatomic) CCShowView *showView;

@end

@implementation CCRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configTabBar];
    
    [self.view addSubview:self.showView];
    [self.showView setCurrentStatus:SHOWSTATUS_UP location:CGPointMake(self.view.width-CCPXToPoint(170), self.view.height-LMLayoutAreaBottomHeight-CCPXToPoint(260)) animated:NO];
    [self refreshShowViewState];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self startRequestDoingOrder];
}

- (void)configTabBar
{
    [self.tabBar setTranslucent:YES];
    
    _homeController = [[CCHomeViewController alloc] init];
    _scoreController = [[CCScoreViewController alloc] init];
    _messageController = [[CCMessageViewController alloc] init];
    
    [self setViewControllers:@[_homeController, _scoreController, _messageController] animated:YES];
    
    UITabBarItem *spaceItem = [self.tabBar.items objectAtIndex:0];
    UITabBarItem *browserItem = [self.tabBar.items objectAtIndex:1];
    UITabBarItem *settingItem = [self.tabBar.items objectAtIndex:2];
    
    [spaceItem setTag:0];
    [browserItem setTag:1];
    [settingItem setTag:2];
    
    [spaceItem setImage:[UIImage imageNamed:@"Home_Item_Normal"]];
    [browserItem setImage:[UIImage imageNamed:@"Score_Item_Normal"]];
    [settingItem setImage:[UIImage imageNamed:@"Message_Item_Normal"]];
    
    [spaceItem setSelectedImage:[UIImage imageNamed:@"Home_Item_Highlight"]];
    [browserItem setSelectedImage:[UIImage imageNamed:@"Score_Item_Hightlight"]];
    [settingItem setSelectedImage:[UIImage imageNamed:@"Message_Item_Highlight"]];
    
    [spaceItem setImageInsets:UIEdgeInsetsMake(0.f, 0.f, -0.f, 0.f)];
    [browserItem setImageInsets:UIEdgeInsetsMake(0.f, 0.f, -0.f, 0.f)];
    [settingItem setImageInsets:UIEdgeInsetsMake(0.f, 0.f, -0.f, 0.f)];
    
    [spaceItem setTitle:@"首页"];
    [browserItem setTitle:@"上分"];
    [settingItem setTitle:@"消息"];

    [spaceItem setTitleTextAttributes:@{NSFontAttributeName:Font_Tiny} forState:UIControlStateNormal];
    [browserItem setTitleTextAttributes:@{NSFontAttributeName:Font_Tiny} forState:UIControlStateNormal];
    [settingItem setTitleTextAttributes:@{NSFontAttributeName:Font_Tiny} forState:UIControlStateNormal];
    
    [spaceItem setTitleTextAttributes:@{NSFontAttributeName:Font_Tiny,NSForegroundColorAttributeName:FontColor_Yellow} forState:UIControlStateSelected];
    [browserItem setTitleTextAttributes:@{NSFontAttributeName:Font_Tiny,NSForegroundColorAttributeName:FontColor_Yellow} forState:UIControlStateSelected];
    [settingItem setTitleTextAttributes:@{NSFontAttributeName:Font_Tiny,NSForegroundColorAttributeName:FontColor_Yellow} forState:UIControlStateSelected];
    
    [spaceItem setTitlePositionAdjustment:UIOffsetMake(0, -2.f)];
    [browserItem setTitlePositionAdjustment:UIOffsetMake(0, -2.f)];
    [settingItem setTitlePositionAdjustment:UIOffsetMake(0, -2.f)];
}

#pragma mark - CCShowViewDelegate
- (void)didClickShowView:(SHOWSTATUS)status
{
    CCScoreWaitViewController *vc = [CCScoreWaitViewController new];
    
    //修改push方向
    CATransition* transition = [CATransition animation];
    transition.type          = kCATransitionMoveIn;//可更改为其他方式
    transition.subtype       = kCATransitionFromTop;//可更改为其他方式
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:vc animated:NO];
}

#pragma mark - CCRequestDelegate
- (void)onRequestSuccess:(NSDictionary *)dict sender:(id)sender
{
    if (self.request != sender)
    {
        return;
    }
    
    if (self.request.orderList && self.request.orderList.count>0)
    {
        CCAccountServiceInstance.hasDoingOrder = YES;
    }
    else
    {
        CCAccountServiceInstance.hasDoingOrder = NO;
    }
    self.request = nil;
    [self refreshShowViewState];
}

- (void)onRequestFailed:(NSInteger)errorCode errorMsg:(NSString *)msg sender:(id)sender
{
    if (self.request != sender)
    {
        return;
    }
    self.request = nil;
}

#pragma mark - private
- (void)startRequestDoingOrder
{
    if (self.request)
    {
        return;
    }
    
    self.request = [CCOrderRequest new];
    self.request.type = ORDERSOURCE_DOING;
    self.request.gameID = GAMEID_WANGZHE;
    self.request.pageNum = 1;
    self.request.pageSize = 20;
    self.request.status = 2;
    [self.request startPostRequestWithDelegate:self];
}

- (void)refreshShowViewState
{
    [self.showView setHidden:!CCAccountServiceInstance.hasDoingOrder];
}

#pragma mark - getter
- (CCShowView *)showView
{
    if (!_showView)
    {
        _showView = [CCShowView new];
        [_showView setDelegate:self];
    }
    return _showView;
}

@end
