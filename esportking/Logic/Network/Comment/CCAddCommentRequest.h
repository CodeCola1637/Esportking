//
//  CCAddCommentRequest.h
//  esportking
//
//  Created by jaycechen on 2018/3/19.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCBaseRequest.h"

@interface CCAddCommentRequest : CCBaseRequest

@property (assign, nonatomic) uint64_t userID;
@property (assign, nonatomic) GAMEID gameID;
@property (assign, nonatomic) uint32_t startCount;
@property (assign, nonatomic) uint32_t successCount;
@property (assign, nonatomic) uint32_t totalCount;
@property (strong, nonatomic) NSArray<NSNumber *> *tagList;
@property (strong, nonatomic) NSString *commentContent;

@end
