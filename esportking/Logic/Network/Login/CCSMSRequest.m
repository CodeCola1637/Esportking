//
//  CCSMSRequest.m
//  esportking
//
//  Created by CKQ on 2018/2/6.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCSMSRequest.h"

@implementation CCSMSRequest

- (NSString *)subAddress
{
    return GetSMSCode;
}

- (NSDictionary *)requestParam
{
    return @{
             @"mobile":CCNoNilStr(self.phoneNum),
             @"type":@(self.type)
             };
}

@end
