//
//  CCComeInWebViewController.m
//  esportking
//
//  Created by CKQ on 2018/4/5.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCComeInWebViewController.h"
#import "CCComeInViewController.h"

#import "CCCommitButton.h"
#import "CCNetworkDefine.h"

@interface CCComeInWebViewController ()

@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) CCCommitButton *confirmButton;

@end

@implementation CCComeInWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configTopBar];
    [self configContent];
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:ComeInHtml]];
    [self.webView loadRequest:req];
}

- (void)configTopBar
{
    [self setContentWithTopOffset:LMStatusBarHeight+LMTopBarHeight bottomOffset:LMLayoutAreaBottomHeight];
    [self addTopPopBackButton];
    [self addTopbarTitle:@"大神协议"];
}

- (void)configContent
{
    [self.contentView addSubview:self.webView];
    [self.contentView addSubview:self.confirmButton];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.confirmButton.mas_top);
    }];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(CCPXToPoint(96));
    }];
}

#pragma mark - action
- (void)onClickConfirmButton:(id)sender
{
    CCComeInViewController *vc = [CCComeInViewController new];
    [self.navigationController pushViewController:vc animated:YES];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableArray *array = [[NSMutableArray alloc] initWithArray:self.navigationController.viewControllers];
        [array removeObject:self];
        [self.navigationController setViewControllers:array];
    });
}

#pragma mark - getter
- (UIWebView *)webView
{
    if (!_webView)
    {
        _webView = [UIWebView new];
    }
    return _webView;
}

- (CCCommitButton *)confirmButton
{
    if (!_confirmButton)
    {
        _confirmButton = [CCCommitButton new];
        [_confirmButton setTitle:@"同意" forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(onClickConfirmButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

@end

