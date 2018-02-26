//
//  CCCommentModel.h
//  esportking
//
//  Created by CKQ on 2018/2/25.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCCommentModel : NSObject

@property (assign, nonatomic) uint64_t hostID;      // 被评论者的ID

@property (assign, nonatomic) uint64_t commentID;
@property (assign, nonatomic) uint64_t userID;
@property (assign, nonatomic) uint64_t gameID;
@property (assign, nonatomic) uint64_t star;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *headUrl;
@property (strong, nonatomic) NSString *comment;
@property (strong, nonatomic) NSString *createTime;
@property (assign, nonatomic) uint64_t successCount;
@property (assign, nonatomic) uint64_t totalCount;

- (instancetype)initWithComment:(NSDictionary *)dict;

@end
