//
//  CCChangeUserInfoViewController.m
//  esportking
//
//  Created by jaycechen on 2018/3/12.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCChangeUserInfoViewController.h"
#import "CCAddImageListView.h"
#import "CCTitleItem.h"

#import "CCModifyUserInfoRequest.h"
#import "CCAccountService.h"

@interface CCChangeUserInfoViewController ()

@property (strong, nonatomic) CCAddImageListView *addListView;
@property (strong, nonatomic) CCTitleItem   *nameItem;
@property (strong, nonatomic) CCTitleItem   *sexItem;
@property (strong, nonatomic) CCTitleItem   *ageItem;
@property (strong, nonatomic) CCTitleItem   *locationItem;

@property (strong, nonatomic) CCModifyUserInfoRequest *request;

@end

@implementation CCChangeUserInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

@end
