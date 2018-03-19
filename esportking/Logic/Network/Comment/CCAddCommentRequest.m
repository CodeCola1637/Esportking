//
//  CCAddCommentRequest.m
//  esportking
//
//  Created by jaycechen on 2018/3/19.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCAddCommentRequest.h"

@implementation CCAddCommentRequest

- (NSString *)subAddress
{
    return AddComment;
}

- (NSDictionary *)requestParam
{
    return @{
             @"user_id":@(self.userID),
             @"star":@(self.startCount),
             @"total_count":@(self.totalCount),
             @"succ_count":@(self.successCount),
             @"game_id":@(self.gameID),
             @"tags":self.tagList,
             @"content":CCNoNilStr(self.commentContent)
             };
}

@end
