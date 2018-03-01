//
//  CCBeautyViewController.m
//  esportking
//
//  Created by jaycechen on 2018/2/28.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCBeautyViewController.h"
#import "CCUserDetailViewController.h"

#import "CCRefreshCollectionView.h"
#import "CCGameItemCollectionViewCell.h"

#import "CCHomePageManager.h"

#define kIdentify   @"identify"

@interface CCBeautyViewController ()<CCHomePageDelegate, UICollectionViewDelegate, UICollectionViewDataSource, CCRefreshDelegate>

@property (strong, nonatomic) CCRefreshCollectionView *collectionView;
@property (strong, nonatomic) CCHomePageManager *manager;

@end

@implementation CCBeautyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configTopbar];
    [self configContent];
    [self.collectionView beginHeaderRefreshing];
}


- (void)configTopbar
{
    [self addTopPopBackButton];
    [self addTopbarTitle:@"美女陪玩"];
}

- (void)configContent
{
    [self setContentWithTopOffset:LMStatusBarHeight+LMTopBarHeight bottomOffset:0];
    
    [self.contentView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

#pragma mark - CCRefreshDelegate
- (void)onHeaderRefresh
{
    [self.manager startRefreshWithGameID:GAMEID_WANGZHE gender:GENDER_GIRL];
}

- (void)onFooterRefresh
{
    [self.manager startLoadMoreWithGameID:GAMEID_WANGZHE gender:GENDER_GIRL];
}

#pragma mark - CCHomePageDelegate
- (void)onRefreshHomePageSuccessWithRcmList:(NSArray<CCGameModel *> *)rcmList normalList:(NSArray<CCGameModel *> *)normalList
{
    [self.collectionView reloadData];
}

- (void)onRefreshHomePageFailed:(NSInteger)code errorMsg:(NSString *)msg
{
    [self showToast:msg];
    [self.collectionView endRefresh];
}

- (void)onLoadMoreHomePageSuccessWithNormalList:(NSArray<CCGameModel *> *)normalList
{
    [self.collectionView reloadData];
}

- (void)onLoadMoreHomePageFailed:(NSInteger)code errorMsg:(NSString *)msg
{
    [self showToast:msg];
    [self.collectionView endRefresh];
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CCGameModel *model = [self.manager getAllNormalList][indexPath.row];
    CCUserDetailViewController *vc = [[CCUserDetailViewController alloc] initWithUserID:model.userModel.userID gameID:model.gameID userGameID:model.userGameID];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.manager getAllNormalList].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CCGameItemCollectionViewCell *cell = (CCGameItemCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kIdentify forIndexPath:indexPath];
    [cell setGameModel:[self.manager getAllNormalList][indexPath.row]];
    return cell;
}

#pragma mark - getter
- (CCHomePageManager *)manager
{
    if (!_manager)
    {
        _manager = [[CCHomePageManager alloc] initWithPageType:HOMEPAGETYPE_BEAUTYPAGE Delegate:self];
    }
    return _manager;
}

- (CCRefreshCollectionView *)collectionView
{
    if (!_collectionView)
    {
        _collectionView = [[CCRefreshCollectionView alloc] init];
        _collectionView.collectionView.dataSource = self;
        _collectionView.collectionView.delegate = self;
        [_collectionView setRefreshDelegate:self];
        [_collectionView.collectionView registerClass:[CCGameItemCollectionViewCell class] forCellWithReuseIdentifier:kIdentify];
        [_collectionView.collectionLayout setLineSpacing:CCPXToPoint(12)];
        [_collectionView.collectionLayout setRowSpacing:CCPXToPoint(12)];
        [_collectionView.collectionLayout calculateItemSizeWithWidthBlock:^CGSize(NSIndexPath *indexPath) {
            CGFloat width = (LM_SCREEN_WIDTH-CCPXToPoint(86))/2.f;
            return CGSizeMake(width, width);
        } andLeftPaddingBlock:^CGFloat(NSIndexPath *indexPath) {
            return CCPXToPoint(37);
        }];
    }
    return _collectionView;
}

@end
