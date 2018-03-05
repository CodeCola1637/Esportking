//
//  CCSearchHistoryService.h
//  esportking
//
//  Created by jaycechen on 2018/3/5.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CCHistoryServiceInstance [CCHistoryService shareInstance]

@interface CCHistoryService : NSObject

+ (instancetype)shareInstance;

- (void)addSearchHistory:(NSString *)word;
- (NSArray<NSString *> *)getSearchHistory;
- (void)clearSearchHistory;

@end
