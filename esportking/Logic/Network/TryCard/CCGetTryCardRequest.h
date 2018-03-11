//
//  CCTryCardRequest.h
//  esportking
//
//  Created by jaycechen on 2018/3/1.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCBaseRequest.h"
#import "CCTryCardModel.h"

@interface CCGetTryCardRequest : CCBaseRequest

@property (assign, nonatomic) uint32_t pageIndex;
@property (assign, nonatomic) uint32_t pageNumber;

@property (strong, nonatomic) NSMutableArray<CCTryCardModel *> *cardList;

@end
