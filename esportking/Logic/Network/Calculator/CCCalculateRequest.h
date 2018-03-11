//
//  CCCalculateRequest.h
//  esportking
//
//  Created by jaycechen on 2018/3/11.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCBaseRequest.h"

@interface CCCalculateRequest : CCBaseRequest

@property (assign, nonatomic) uint32_t fromDan;
@property (assign, nonatomic) uint32_t fromDetailLevel;
@property (assign, nonatomic) uint32_t fromDetailStar;
@property (assign, nonatomic) uint32_t toDan;
@property (assign, nonatomic) uint32_t toDetailLevel;
@property (assign, nonatomic) uint32_t toDetailStar;
@property (assign, nonatomic) uint32_t count;

@end
