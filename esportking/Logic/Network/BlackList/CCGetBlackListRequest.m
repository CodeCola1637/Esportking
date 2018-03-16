//
//  CCGetBlackListRequest.m
//  esportking
//
//  Created by jaycechen on 2018/3/16.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCGetBlackListRequest.h"

@implementation CCGetBlackListRequest

- (NSString *)subAddress
{
    return GetMyBlackList;
}

- (void)decodeData:(NSDictionary *)resp
{
    NSArray *list = resp[@"data"];
    NSMutableArray *array = [NSMutableArray new];
    
    for (int i=0; i<list.count; i++)
    {
        NSDictionary *dict = list[i];
        CCUserModel *userModel = [CCUserModel new];
        userModel.userID = [dict[@"otherId"] unsignedIntegerValue];
        userModel.name = dict[@"userName"];
        userModel.headUrl = dict[@"picture"];
        [array addObject:userModel];
    }
    self.userList = array;
}

@end
