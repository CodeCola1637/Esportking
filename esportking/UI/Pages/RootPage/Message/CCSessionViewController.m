//
//  CCSessionViewController.m
//  esportking
//
//  Created by CKQ on 2018/2/26.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCSessionViewController.h"

@interface CCSessionViewController ()

@property (strong, nonatomic) NSString *displayTitle;
@property (strong, nonatomic) NIMSessionViewController *chatVC;

@end

@implementation CCSessionViewController

- (instancetype)initWithSession:(NIMSession *)session title:(NSString *)title
{
    if (self = [super init])
    {
        self.displayTitle = title;
        self.chatVC = [[NIMSessionViewController alloc] initWithSession:session];
        [self addChildViewController:self.chatVC];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configTopbar];
    [self configContent];
    
    [self.chatVC.tableView reloadData];
}

- (void)configTopbar
{
    [self addTopPopBackButton];
    [self addTopbarTitle:(self.displayTitle ? self.displayTitle : @"聊天")];
}

- (void)configContent
{
    [self setContentWithTopOffset:LMStatusBarHeight+LMTopBarHeight bottomOffset:0];
    
    [self.contentView addSubview:self.chatVC.view];
    [self.chatVC.view setFrame:self.contentView.bounds];
//    [self.chatVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.contentView);
//    }];
}

@end
