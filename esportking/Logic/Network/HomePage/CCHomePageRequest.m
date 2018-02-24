//
//  CCHomePageRequest.m
//  esportking
//
//  Created by CKQ on 2018/2/9.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCHomePageRequest.h"

@implementation CCHomePageRequest

- (NSString *)subAddress
{
    return HomePage;
}

- (NSDictionary *)requestParam
{
    return @{
             @"game_id":@(_gameID),
             @"pageNumber":@(_pageNum),
             @"pageSize":@(_pageSize),
             @"gender":@(_gender)
             };
}

@end
