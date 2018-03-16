//
//  CCGetBlackListRequest.h
//  esportking
//
//  Created by jaycechen on 2018/3/16.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCBaseRequest.h"
#import "CCUserModel.h"

@interface CCGetBlackListRequest : CCBaseRequest

// resp
@property (strong, nonatomic) NSMutableArray<CCUserModel *> *userList;

@end
