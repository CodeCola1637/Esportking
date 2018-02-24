//
//  CCHomePageRequest.h
//  esportking
//
//  Created by CKQ on 2018/2/9.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCBaseRequest.h"

typedef enum : NSUInteger {
    HOMEPAGETYPE_ROOTPAGE = 0,
    HOMEPAGETYPE_BEAUTYPAGE,
    HOMEPAGETYPE_COUNT,
} HOMEPAGETYPE;

@interface CCHomePageRequest : CCBaseRequest

@property (assign, nonatomic) HOMEPAGETYPE type;
@property (assign, nonatomic) uint64_t  gameID;
@property (assign, nonatomic) uint64_t  pageNum;
@property (assign, nonatomic) uint64_t  pageSize;
@property (assign, nonatomic) GENDER    gender;

@end
