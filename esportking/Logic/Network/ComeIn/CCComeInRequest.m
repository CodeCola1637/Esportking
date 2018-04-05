//
//  CCComeInRequest.m
//  esportking
//
//  Created by CKQ on 2018/4/5.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCComeInRequest.h"

@implementation CCComeInRequest

- (NSString *)subAddress
{
    return ComeInGame;
}

- (NSDictionary *)requestParam
{
    return @{
             @"game_id":@(GAMEID_WANGZHE),
             @"service_client_type":@(self.model.platformType),
             @"client_type":@(self.model.clientType),
             @"skilled":CCNoNilStr(self.model.skilled),
             @"position":CCNoNilStr(self.model.position),
             @"gender":@(self.model.gender),
             @"honour":CCNoNilStr(self.model.honour),
             //@"order_type":@(1),
             //@"deposit":@(10),
             //@"contact":CCNoNilStr(self.model.contact),
             @"max_dan":CCNoNilStr(self.model.maxDan),
             };
}

@end
