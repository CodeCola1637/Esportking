//
//  CCPublishOrderRequest.m
//  esportking
//
//  Created by jaycechen on 2018/3/11.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCPublishOrderRequest.h"

@implementation CCPublishOrderRequest

- (NSString *)subAddress
{
    return PublishOrder;
}

- (NSDictionary *)requestParam
{
    return @{
             @"receive_id":@(self.receiverID),
             @"game_id":@(self.gameID),
             @"service_area":self.systemPlatformStr,
             @"service_client_type":@(self.platform),
             @"client_type":@(self.system),
             @"number":@(self.gameCount),
             @"type":@(self.scoreStyle),
             @"dan":self.danStr,
             @"formId":@(self.fromDan),
             @"formLevel":@(self.fromDetailDan),
             @"formStar":@(self.fromStar),
             @"toId":@(self.toDan),
             @"toLevel":@(self.toDetailDan),
             @"toStar":@(self.toStar)
             };
}

- (void)decodeData:(NSDictionary *)resp
{
    self.notifyCount = (uint32_t)[resp[@"data"][@"amount"] unsignedIntegerValue];
    self.orderID = resp[@"data"][@"order_number"];
}

@end
