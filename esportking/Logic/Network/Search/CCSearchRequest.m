//
//  CCSearchRequest.m
//  esportking
//
//  Created by CKQ on 2018/2/18.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCSearchRequest.h"

@implementation CCSearchRequest

- (NSString *)subAddress
{
    return Search;
}

- (NSDictionary *)requestParam
{
    return @{
             @"game_id":@(self.gameID),
             @"userName":CCNoNilStr(self.keywords)
             };
}

@end
