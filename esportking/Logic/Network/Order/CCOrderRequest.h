//
//  CCOrderRequest.h
//  esportking
//
//  Created by jaycechen on 2018/2/28.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCBaseRequest.h"

@interface CCOrderRequest : CCBaseRequest

@property (assign, nonatomic) ORDERSTATUS type;
@property (assign, nonatomic) uint64_t gameID;
@property (assign, nonatomic) uint64_t pageNum;
@property (assign, nonatomic) uint64_t pageSize;

@end
