//
//  CCCalculateRequest.m
//  esportking
//
//  Created by jaycechen on 2018/3/11.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCCalculateRequest.h"

@implementation CCCalculateRequest

- (NSString *)subAddress
{
    return Calculate;
}

- (NSDictionary *)requestParam
{
    return @{
             @"number":@(self.count),
             @"formId":@(self.fromDan),
             @"formLevel":@(self.fromDetailLevel),
             @"formStar":@(self.fromDetailStar),
             @"toId":@(self.toDan),
             @"toLevel":@(self.toDetailLevel),
             @"toStar":@(self.toDetailStar)
             };
}

@end
