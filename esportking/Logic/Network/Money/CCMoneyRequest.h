//
//  CCMoneyRequest.h
//  esportking
//
//  Created by jaycechen on 2018/2/28.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCBaseRequest.h"

@interface CCMoneyRequest : CCBaseRequest

@property (assign, nonatomic) MONEYTYPE type;
@property (assign, nonatomic) uint32_t pageIndex;

@property (strong, nonatomic) NSArray *moneyList;

@end
