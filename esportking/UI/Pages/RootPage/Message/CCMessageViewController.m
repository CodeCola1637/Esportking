//
//  CCMessageViewController.m
//  esportking
//
//  Created by CKQ on 2018/2/26.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCMessageViewController.h"
#import "CCSessionListViewController.h"

@interface CCMessageViewController ()

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) CCSessionListViewController *chatListVC;

@end

@implementation CCMessageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configTopbar];
    [self configContent];
}

- (void)configTopbar
{
    [self.topbarView layoutMidControls:@[self.titleLabel] spacing:nil];
}

- (void)configContent
{
    [self setContentWithTopOffset:LMStatusBarHeight+LMTopBarHeight bottomOffset:0];
    
    [self addChildViewController:self.chatListVC];
    [self.contentView addSubview:self.chatListVC.view];
    
    [self.chatListVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [UILabel createOneLineLabelWithFont:Font_Big color:FontColor_Black];
        [_titleLabel setText:@"消息"];
    }
    return _titleLabel;
}

- (CCSessionListViewController *)chatListVC
{
    if (!_chatListVC)
    {
        _chatListVC = [[CCSessionListViewController alloc] init];
    }
    return _chatListVC;
}

@end
