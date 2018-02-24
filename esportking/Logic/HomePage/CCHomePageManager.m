//
//  CCHomePageManager.m
//  esportking
//
//  Created by CKQ on 2018/2/11.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCHomePageManager.h"
#import "CCHomePageRequest.h"

#define kPageSize    20

@interface CCHomePageManager()<CCRequestDelegate>

@property (assign, nonatomic) HOMEPAGETYPE type;
@property (weak  , nonatomic) id<CCHomePageDelegate> delegate;
@property (assign, nonatomic) HOMEPAGETYPE currentPageNum;
@property (strong, nonatomic) CCHomePageRequest *request;
@property (strong, nonatomic) NSMutableArray<CCGameModel *> *allRcmList;
@property (strong, nonatomic) NSMutableArray<CCGameModel *> *normalList;

@end

@implementation CCHomePageManager

- (instancetype)initWithPageType:(HOMEPAGETYPE)type Delegate:(id<CCHomePageDelegate>)delegate
{
    if (self = [super init])
    {
        _type = type;
        _delegate = delegate;
        _currentPageNum = 1;
    }
    return self;
}

- (void)startRefreshWithGameID:(uint64_t)gameID gender:(GENDER)gender
{
    if (_request)
    {
        return;
    }
    _request = [CCHomePageRequest new];
    _request.type   = self.type;
    _request.gameID = gameID;
    _request.gender = gender;
    _request.pageNum = _currentPageNum;
    _request.pageSize = kPageSize;
    [_request startPostRequestWithDelegate:self];
}

- (void)startLoadMoreWithGameID:(uint64_t)gameID gender:(GENDER)gender
{
    if (_request)
    {
        return;
    }
    _request = [CCHomePageRequest new];
    _request.type   = self.type;
    _request.gameID = gameID;
    _request.gender = gender;
    _request.pageNum = _currentPageNum;
    _request.pageSize = kPageSize;
    [_request startPostRequestWithDelegate:self];
}

- (NSArray<CCGameModel *> *)getAllRcmList
{
    return [self.allRcmList copy];
}

- (NSArray<CCGameModel *> *)getAllNormalList
{
    return [self.normalList copy];
}

#pragma mark - CCRequestDelegate
- (void)onRequestSuccess:(NSDictionary *)dict sender:(id)sender
{
    if (_request != sender)
    {
        return;
    }
    if (_request.pageNum == 1)
    {
        self.allRcmList = [self getRcmList:dict];
        self.normalList = [self getNormalList:dict];
        [self.delegate onRefreshHomePageSuccessWithRcmList:self.allRcmList normalList:self.getAllNormalList];
    }
    else
    {
        NSMutableArray *array = [self getNormalList:dict];
        [self.normalList addObjectsFromArray:array];
        [self.delegate onLoadMoreHomePageSuccessWithNormalList:array];
    }
    _request = nil;
}

- (void)onRequestFailed:(NSInteger)errorCode errorMsg:(NSString *)msg sender:(id)sender
{
    if (_request != sender)
    {
        return;
    }
    if (_request.pageNum == 1)
    {
        [self.delegate onRefreshHomePageFailed:errorCode errorMsg:msg];
    }
    else
    {
        [self.delegate onLoadMoreHomePageFailed:errorCode errorMsg:msg];
    }
    _request = nil;
}

- (NSMutableArray<CCGameModel *> *)getRcmList:(NSDictionary *)dict
{
    NSMutableArray *array = [NSMutableArray new];
    NSArray *rcmList = dict[@"data"][@"recommendList"];
    for (int i=0; i<rcmList.count; i++)
    {
        CCGameModel *model = [[CCGameModel alloc] init];
        [model setGameInfo:rcmList[i]];
        [array addObject:model];
    }
    return array;
}

- (NSMutableArray<CCGameModel *> *)getNormalList:(NSDictionary *)dict
{
    NSMutableArray *array = [NSMutableArray new];
    NSArray *normalList = dict[@"data"][@"gameList"];
    for (int i=0; i<normalList.count; i++)
    {
        CCGameModel *model = [[CCGameModel alloc] init];
        [model setGameInfo:normalList[i]];
        [array addObject:model];
    }
    return array;
}

@end
