//
//  CCTryCardModel.m
//  esportking
//
//  Created by jaycechen on 2018/3/11.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCTryCardModel.h"

@implementation CCTryCardModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.cardID = dict[@"car_number"];
        self.status = [dict[@"status"] unsignedIntegerValue];
        self.discount = (uint32_t)[dict[@"discount"] unsignedIntegerValue];
        self.infoStr = dict[@"info"];
    }
    return self;
}

@end
