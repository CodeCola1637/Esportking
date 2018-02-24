//
//  CCHomePageManager.h
//  esportking
//
//  Created by CKQ on 2018/2/11.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCGameModel.h"
#import "CCHomePageRequest.h"

@protocol CCHomePageDelegate<NSObject>

- (void)onRefreshHomePageSuccessWithRcmList:(NSArray<CCGameModel *> *)rcmList normalList:(NSArray<CCGameModel *> *)normalList;
- (void)onRefreshHomePageFailed:(NSInteger)code errorMsg:(NSString *)msg;

- (void)onLoadMoreHomePageSuccessWithNormalList:(NSArray<CCGameModel *> *)normalList;
- (void)onLoadMoreHomePageFailed:(NSInteger)code errorMsg:(NSString *)msg;

@end

@interface CCHomePageManager : NSObject

- (instancetype)initWithPageType:(HOMEPAGETYPE)type Delegate:(id<CCHomePageDelegate>)delegate;

- (void)startRefreshWithGameID:(uint64_t)gameID gender:(GENDER)gender;
- (void)startLoadMoreWithGameID:(uint64_t)gameID gender:(GENDER)gender;;

- (NSArray<CCGameModel *> *)getAllRcmList;
- (NSArray<CCGameModel *> *)getAllNormalList;

@end
