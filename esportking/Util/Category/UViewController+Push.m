//
//  UViewController+Push.m
//  esportking
//
//  Created by CKQ on 2018/4/7.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "UViewController+Push.h"

@implementation UIViewController (Push)

- (void)pushViewController:(UIViewController *)vc andRemoveSelf:(BOOL)remove
{
    [self.navigationController pushViewController:vc animated:YES];
    if (remove)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSMutableArray *array = [[NSMutableArray alloc] initWithArray:self.navigationController.viewControllers];
            [array removeObject:self];
            [self.navigationController setViewControllers:array];
        });
    }
}

@end
