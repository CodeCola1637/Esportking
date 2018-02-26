//
//  CCCommentModel.m
//  esportking
//
//  Created by CKQ on 2018/2/25.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCCommentModel.h"

@implementation CCCommentModel

- (instancetype)initWithComment:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.commentID = [dict[@"id"] unsignedIntegerValue];
        self.gameID = [dict[@"game_id"] unsignedIntegerValue];
        self.hostID = [dict[@"user_id"] unsignedIntegerValue];
        self.userID = [dict[@"other_id"] unsignedIntegerValue];
        self.userName = dict[@"otherUser"][@"userName"];
        self.headUrl = dict[@"otherUser"][@"picture"];
        self.star = [dict[@"star"] unsignedIntegerValue];
        self.comment = dict[@"content"];
        self.createTime = dict[@"create_time"];
        self.successCount = [dict[@"succ_count"] unsignedIntegerValue];
        self.totalCount = [dict[@"total_count"] unsignedIntegerValue];
    }
    return self;
}

@end
