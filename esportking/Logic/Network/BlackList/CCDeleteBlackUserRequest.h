//
//  CCDeleteBlackUserRequest.h
//  esportking
//
//  Created by jaycechen on 2018/3/16.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCBaseRequest.h"

@interface CCDeleteBlackUserRequest : CCBaseRequest

@property (assign, nonatomic) uint64_t userID;

@property (weak, nonatomic) id context;

@end
