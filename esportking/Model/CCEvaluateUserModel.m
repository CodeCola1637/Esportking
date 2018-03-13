//
//  CCEvaluateUserModel.m
//  esportking
//
//  Created by jaycechen on 2018/3/9.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCEvaluateUserModel.h"

@implementation CCEvaluateUserModel

- (instancetype)initWithUserModel:(CCUserModel *)userModel
{
    if (self = [super init])
    {
        self.userID = userModel.userID;
        self.name = userModel.name;
        self.star = userModel.star;
        self.gender = userModel.gender;
        self.age = userModel.age;
        self.headUrl = userModel.headUrl;
    }
    return self;
}

@end
