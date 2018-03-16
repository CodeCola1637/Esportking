//
//  CCGetMyBindRequest.m
//  esportking
//
//  Created by jaycechen on 2018/3/16.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCGetMyBindRequest.h"

@implementation CCGetMyBindRequest

- (NSString *)subAddress
{
    return GetMyBind;
}

- (void)decodeData:(NSDictionary *)resp
{
    NSString *mobile = resp[@"data"][@"mobile"];
    self.phone = CCNoNilStr(mobile)?:nil;
    self.wxBinded = [resp[@"data"][@"weixin"] boolValue];
    self.qqBinded = [resp[@"data"][@"qq"] boolValue];
}

@end
