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

@interface CCRootViewController ()

@property (strong, nonatomic) CCHomeViewController      *homeController;
@property (strong, nonatomic) CCScoreViewController     *scoreController;
@property (strong, nonatomic) CCMessageViewController   *messageController;

@end

@implementation CCRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configTabBar];
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

@end
