//
//  CCSessionListViewController.m
//  esportking
//
//  Created by CKQ on 2018/2/26.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCSessionListViewController.h"
#import "CCSessionViewController.h"

@interface CCSessionListViewController ()

@end

@implementation CCSessionListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)onSelectedRecent:(NIMRecentSession *)recent
             atIndexPath:(NSIndexPath *)indexPath
{
    CCSessionViewController *vc = [[CCSessionViewController alloc] initWithSession:recent.session title:[self nameForRecentSession:recent]];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
