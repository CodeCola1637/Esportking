//
//  CCSearchHistoryService.m
//  esportking
//
//  Created by jaycechen on 2018/3/5.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCHistoryService.h"

#define kSearchCategory @"category_search"

#define kSearchHistoryLimit 5

@implementation CCHistoryService

+ (instancetype)shareInstance
{
    static CCHistoryService *service;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[CCHistoryService alloc] init];
    });
    return service;
}

- (void)addSearchHistory:(NSString *)word
{
    if (word && word.length > 0)
    {
        NSMutableArray *array = [NSMutableArray arrayWithArray:[self getObjectForCategory:kSearchCategory]];
        [array removeObject:word];
        [array insertObject:word atIndex:0];
        while (array.count > kSearchHistoryLimit)
        {
            [array removeLastObject];
        }
        [self setObject:array forCategory:kSearchCategory];
    }
}

- (NSArray<NSString *> *)getSearchHistory
{
    return [self getObjectForCategory:kSearchCategory];
}

- (void)clearSearchHistory
{
    [self clearObjectForCategory:kSearchCategory];
}

#pragma mark - private
- (void)setObject:(id)object forCategory:(NSString *)category
{
    if (object == nil)
    {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:CCNoNilStr(category)];
}

- (id)getObjectForCategory:(NSString *)category
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:CCNoNilStr(category)];
}

- (void)clearObjectForCategory:(NSString *)category
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:CCNoNilStr(category)];
}

@end
