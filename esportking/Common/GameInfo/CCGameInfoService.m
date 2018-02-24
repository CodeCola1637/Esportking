//
//  CCGameInfoManager.m
//  esportking
//
//  Created by CKQ on 2018/2/14.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCGameInfoService.h"
#import "CCGetGameInfoRequest.h"

@interface CCGameInfoService()<CCRequestDelegate>

@property (strong, nonatomic) NSArray *gameInfoArray;
@property (strong, nonatomic) CCGetGameInfoRequest *request;

@end

@implementation CCGameInfoService

+ (void)load
{
    [self shareInstance];
}

+ (instancetype)shareInstance
{
    static CCGameInfoService *service;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[CCGameInfoService alloc] init];
    });
    return service;
}

- (instancetype)init
{
    if (self = [super init])
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onLogin) name:CCLoginNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSArray *)getGameArray
{
    if (self.gameInfoArray.count == 0)
    {
        [self startGetGameInfo];
        return nil;
    }
    return self.gameInfoArray;
}

- (void)startGetGameInfo
{
    _request = [CCGetGameInfoRequest new];
    [_request startGetRequestWithDelegate:self];
}

#pragma mark - CCRequestDelegate
- (void)onRequestSuccess:(NSDictionary *)dict sender:(id)sender
{
    if (_request != sender)
    {
        return;
    }
    _request = nil;
    
    self.gameInfoArray = dict[@"data"];
}

- (void)onRequestFailed:(NSInteger)errorCode errorMsg:(NSString *)msg sender:(id)sender
{
    if (_request != sender)
    {
        return;
    }
    _request = nil;
}

#pragma mark - Notification
- (void)onLogin
{
    [self startGetGameInfo];
}

@end
