//
//  CCHelpWebViewController.m
//  esportking
//
//  Created by CKQ on 2018/4/5.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCHelpWebViewController.h"
#import "CCNetworkDefine.h"

@interface CCHelpWebViewController ()

@property (strong, nonatomic) UIWebView *webView;

@end

@implementation CCHelpWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configTopBar];
    [self configContent];
    
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:HelpHtml]];
    [self.webView loadRequest:req];
}

- (void)configTopBar
{
    [self setContentWithTopOffset:LMStatusBarHeight+LMTopBarHeight bottomOffset:LMLayoutAreaBottomHeight];
    [self addTopPopBackButton];
    [self addTopbarTitle:@"帮助"];
}

- (void)configContent
{
    [self.contentView addSubview:self.webView];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.contentView);
    }];
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

@end
