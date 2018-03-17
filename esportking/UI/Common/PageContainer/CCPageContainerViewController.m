//
//  CCPageContainerViewController.m
//  esportking
//
//  Created by jaycechen on 2018/2/28.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCPageContainerViewController.h"
#import "ZJScrollPageView.h"

@interface CCPageContainerViewController ()<ZJScrollPageViewDelegate>

@property (strong, nonatomic) NSArray<UIViewController<ZJScrollPageViewChildVcDelegate> *> *viewControllers;
@property (strong, nonatomic) NSArray<NSString *> *titles;
@property (strong, nonatomic) NSString *displayTitle;

@property (strong, nonatomic) ZJScrollPageView *pageView;

@end

@implementation CCPageContainerViewController

- (instancetype)initWithVCs:(NSArray<UIViewController<ZJScrollPageViewChildVcDelegate> *> *)vcs subTitles:(NSArray<NSString *> *)titles andTitle:(NSString *)title
{
    if (self = [super init])
    {
        self.viewControllers = vcs;
        self.titles = titles;
        self.displayTitle = title;
        
        for (UIViewController *vc in vcs)
        {
            [self addChildViewController:vc];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configTopbar];
    [self configContent];
}

- (void)configTopbar
{
    [self addTopPopBackButton];
    [self addTopbarTitle:self.displayTitle];
}

- (void)configContent
{
    [self setContentWithTopOffset:LMStatusBarHeight+LMTopBarHeight bottomOffset:LMLayoutAreaBottomHeight];
    
    [self.contentView addSubview:self.pageView];
    [self.pageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

#pragma mark - ZJScrollPageViewDelegate
- (NSInteger)numberOfChildViewControllers
{
    return self.viewControllers.count;
}

- (UIViewController <ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index
{
    UIViewController<ZJScrollPageViewChildVcDelegate> *childVc = reuseViewController;
    if (!childVc)
    {
        childVc = self.viewControllers[index];
    }
    return childVc;
}

#pragma mark - getter
- (ZJScrollPageView *)pageView
{
    if (!_pageView)
    {
        ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
        style.segmentHeight = CCPXToPoint(80);
        style.titleFont = Font_Big;
        style.normalTitleColor = [UIColor colorWithRGBHex:0x555555];
        style.selectedTitleColor = FontColor_Black;
        style.scrollLineColor = BgColor_Yellow;
        //显示滚动条
        style.showLine = YES;
        // 颜色渐变
        style.gradualChangeTitleColor = YES;
        
        style.animatedContentViewWhenTitleClicked = NO;
        
        style.autoAdjustTitlesWidth = YES;
        
        _pageView = [[ZJScrollPageView alloc] initWithFrame:self.contentView.bounds segmentStyle:style titles:self.titles parentViewController:self delegate:self];
        [_pageView.segmentView setBackgroundColor:[UIColor colorWithRGBHex:0xf2f2f2]];
    }
    return _pageView;
}

@end
