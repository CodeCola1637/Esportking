//
//  CCUserModel.m
//  esportking
//
//  Created by CKQ on 2018/2/9.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCUserModel.h"

@implementation CCUserModel

- (void)setUserInfo:(NSDictionary *)info
{
    self.userID = [info[@"userid"] unsignedIntegerValue];
    self.name = info[@"userName"];
    self.gender = [info[@"gender"] unsignedIntValue];
    self.star = info[@"star"];
    self.headUrl = info[@"picture"];
    self.age = [info[@"age"] unsignedIntValue];
}

@end
