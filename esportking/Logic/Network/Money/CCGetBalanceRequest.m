//
//  CCGetBalanceRequest.m
//  esportking
//
//  Created by jaycechen on 2018/3/15.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCGetBalanceRequest.h"

@implementation CCGetBalanceRequest

- (NSString *)subAddress
{
    return GetBalance;
}

- (void)decodeData:(NSDictionary *)resp
{
    self.balance = [resp[@"data"] floatValue];
}

@end
