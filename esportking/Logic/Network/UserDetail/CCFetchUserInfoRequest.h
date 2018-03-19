//
//  CCFetchUserInfoRequest.h
//  esportking
//
//  Created by jaycechen on 2018/3/19.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCBaseRequest.h"
#import "CCUserModel.h"

@interface CCFetchUserInfoRequest : CCBaseRequest

@property (assign, nonatomic) uint64_t userID;

@property (strong, nonatomic) CCUserModel *userModel;

@end
