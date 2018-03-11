//
//  CCNearbyViewController.m
//  esportking
//
//  Created by CKQ on 2018/3/11.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCNearbyViewController.h"
#import "CCRefreshTableView.h"
#import "CCNearbyTableViewCell.h"

#import "CCNearbyRequest.h"

#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

#define kNearbyIdentify @"nearby_identify"

@interface CCNearbyViewController ()<UITableViewDelegate, UITableViewDataSource, CCRefreshDelegate, AMapLocationManagerDelegate>

@property (strong, nonatomic) CCRefreshTableView *tableView;
@property (strong, nonatomic) MAMapView *mapView;
@property (strong, nonatomic) AMapLocationManager *locationManager;

@property (strong, nonatomic) NSMutableArray<CCGameModel *> *userList;

@end

@implementation CCNearbyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)configTopbar
{
    [self addTopPopBackButton];
    [self addTopbarTitle:@"附近"];
}

- (void)configContent
{
    [self setContentWithTopOffset:LMStatusBarHeight+LMTopBarHeight bottomOffset:LMLayoutAreaBottomHeight];
    
    [self.contentView addSubview:self.mapView];
    [self.contentView addSubview:self.tableView];
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(CCPXToPoint(100));
    }];
}

- (void)configLocationManager
{
    self.locationManager = [[AMapLocationManager alloc] init];
    
    [self.locationManager setDelegate:self];
    
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    
    [self.locationManager setAllowsBackgroundLocationUpdates:YES];
}

- (void)startSerialLocation
{
    //开始定位
    [self.locationManager startUpdatingLocation];
}

- (void)stopSerialLocation
{
    //停止定位
    [self.locationManager stopUpdatingLocation];
}

#pragma mark - CCRefreshDelegate
- (void)onHeaderRefresh
{
    
}

- (void)onFooterRefresh {}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - AMapLocationManagerDelegate
- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error
{
    
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.userList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CCNearbyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kNearbyIdentify];
    [cell setGameModel:self.userList[indexPath.row]];
    return cell;
}

#pragma mark - getter
- (CCRefreshTableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[CCRefreshTableView alloc] initWithFrame:self.view.bounds];
        [_tableView enableFooter:NO];
        [_tableView setRefreshDelegate:self];
        [_tableView.tableView setDataSource:self];
        [_tableView.tableView setDelegate:self];
        [_tableView.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_tableView.tableView registerClass:[CCNearbyTableViewCell class] forCellReuseIdentifier:kNearbyIdentify];
    }
    return _tableView;
}

- (MAMapView *)mapView
{
    if (!_mapView)
    {
        CGRect bounds = self.contentView.bounds;
        _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, bounds.size.height-CCPXToPoint(100))];
    }
    return _mapView;
}

@end
