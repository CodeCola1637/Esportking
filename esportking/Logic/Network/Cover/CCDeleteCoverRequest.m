//
//  CCDeleteCoverRequest.m
//  esportking
//
//  Created by jaycechen on 2018/4/24.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCDeleteCoverRequest.h"

@implementation CCDeleteCoverRequest

- (NSString *)subAddress
{
    return DeleteCover;
}

- (NSDictionary *)requestParam
{
    return @{
             @"covers":CCNoNilStr(self.coverUrl)
             };
}

@end
