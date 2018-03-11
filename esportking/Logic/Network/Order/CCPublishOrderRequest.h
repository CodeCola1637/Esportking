//
//  CCPublishOrderRequest.h
//  esportking
//
//  Created by jaycechen on 2018/3/11.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCBaseRequest.h"

@interface CCPublishOrderRequest : CCBaseRequest

@property (strong, nonatomic) NSString *systemPlatformStr;
@property (strong, nonatomic) NSString *danStr;

@property (assign, nonatomic) uint64_t receiverID;
@property (assign, nonatomic) uint64_t gameID;

@property (assign, nonatomic) uint32_t scoreStyle;
@property (assign, nonatomic) uint32_t system;
@property (assign, nonatomic) uint32_t platform;
@property (assign, nonatomic) uint32_t fromDan;

// 上分专车
@property (assign, nonatomic) uint32_t fromDetailDan;
@property (assign, nonatomic) uint32_t fromStar;
@property (assign, nonatomic) uint32_t toDan;
@property (assign, nonatomic) uint32_t toDetailDan;
@property (assign, nonatomic) uint32_t toStar;

// 娱乐专车
@property (assign, nonatomic) uint32_t gameCount;

@end
