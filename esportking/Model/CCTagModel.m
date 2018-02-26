//
//  CCTagModel.m
//  esportking
//
//  Created by CKQ on 2018/2/25.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCTagModel.h"

@implementation CCTagModel

- (instancetype)initWithTagDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.tagName = dict[@"name"];
        self.tagID = [dict[@"id"] unsignedIntegerValue];
        self.gameID = [dict[@"game_id"] unsignedIntegerValue];
        self.agreeCount = [dict[@"number"] unsignedIntegerValue];
    }
    return self;
}

@end
