//
//  CCGameModel.h
//  esportking
//
//  Created by CKQ on 2018/2/9.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCUserModel.h"

@interface CCGameModel : NSObject

@property (strong, nonatomic) CCUserModel   *userModel;

@property (assign, nonatomic) uint64_t      gameID;
@property (assign, nonatomic) uint64_t      userGameID;
@property (assign, nonatomic) CLIENTTYPE    clientType;
@property (assign, nonatomic) GENDER        gameGender;
@property (assign, nonatomic) uint64_t      auth;
@property (assign, nonatomic) uint64_t      deposit;
@property (assign, nonatomic) ORDERTYPE     orderType;

@property (strong, nonatomic) NSString      *serverName;
@property (strong, nonatomic) NSString      *skilled;
@property (strong, nonatomic) NSString      *position;
@property (strong, nonatomic) NSString      *hornour;
@property (strong, nonatomic) NSString      *contact;
@property (strong, nonatomic) NSString      *maxLevel;
@property (strong, nonatomic) NSString      *recordUrl;
@property (strong, nonatomic) NSString      *createTime;

@property (assign, nonatomic) uint64_t      successRate;    // 胜率
@property (assign, nonatomic) uint64_t      totalCount;     // 接单数
@property (assign, nonatomic) uint64_t      score;          // 评分

- (void)setGameInfo:(NSDictionary *)info;

@end
