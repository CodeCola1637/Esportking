//
//  CCNearbyRequest.h
//  esportking
//
//  Created by CKQ on 2018/3/11.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCBaseRequest.h"
#import "CCGameModel.h"

@interface CCNearbyRequest : CCBaseRequest

@property (assign, nonatomic) uint32_t gameID;
@property (strong, nonatomic) NSString *longitude;
@property (strong, nonatomic) NSString *latitude;

@property (strong, nonatomic) NSMutableArray<CCGameModel *> *userList;

@end
