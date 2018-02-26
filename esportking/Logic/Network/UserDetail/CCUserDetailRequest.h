//
//  CCUserDetailRequest.h
//  esportking
//
//  Created by CKQ on 2018/2/25.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCBaseRequest.h"

@interface CCUserDetailRequest : CCBaseRequest

@property (assign, nonatomic) uint64_t userID;
@property (assign, nonatomic) uint64_t gameID;
@property (assign, nonatomic) uint64_t userGameID;

@end
