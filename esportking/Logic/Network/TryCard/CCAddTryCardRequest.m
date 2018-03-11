//
//  CCAddTryCardRequest.m
//  esportking
//
//  Created by jaycechen on 2018/3/11.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCAddTryCardRequest.h"

@implementation CCAddTryCardRequest

- (NSString *)subAddress
{
    return AddTryCard;
}

- (NSDictionary *)requestParam
{
    return @{
             @"car_number":CCNoNilStr(self.cardID)
             };
}

@end
