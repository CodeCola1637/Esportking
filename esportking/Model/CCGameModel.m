//
//  CCGameModel.m
//  esportking
//
//  Created by CKQ on 2018/2/9.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCGameModel.h"

@implementation CCGameModel

- (void)setGameInfo:(NSDictionary *)info
{
    self.userModel = [CCUserModel new];
    [self.userModel setUserInfo:info];
    
    NSDictionary *gameDict = info[@"game"];
    self.gameID     = [gameDict[@"game_id"] unsignedIntValue];
    self.userGameID = [gameDict[@"user_game_id"] unsignedIntValue];
    self.clientType = [gameDict[@"client_type"] unsignedIntValue];
    self.gameGender = [gameDict[@"gender"] unsignedIntValue];
    self.auth       = [gameDict[@"auth"] unsignedIntValue];
    self.orderType  = [gameDict[@"order_type"] unsignedIntValue];
    self.serverName = gameDict[@"service_area"];
    self.skilled    = gameDict[@"skilled"];
    self.position   = gameDict[@"position"];
    self.honour    = gameDict[@"honour"];
    self.contact    = gameDict[@"contact"];
    self.maxLevel   = gameDict[@"max_dan"];
    self.recordUrl  = gameDict[@"military_succ"];
    self.createTime = gameDict[@"create_time"];
    
    self.successRate = [gameDict[@"successRate"] unsignedIntegerValue];
    self.totalCount  = [gameDict[@"totalCount"] unsignedIntegerValue];
    self.score       = [gameDict[@"score"] floatValue];
}

@end
