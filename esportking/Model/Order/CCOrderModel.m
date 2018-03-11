//
//  CCOrderModel.m
//  esportking
//
//  Created by jaycechen on 2018/3/11.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCOrderModel.h"

@implementation CCOrderModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.orderID = dict[@"order_number"];
        self.status = [dict[@"status"] unsignedIntegerValue];
        self.payStatus = [dict[@"pay_status"] unsignedIntegerValue];
        self.money = (uint32_t)[dict[@"amount"] unsignedIntegerValue];
        self.style = [dict[@"type"] unsignedIntegerValue];
        self.clientType = [dict[@"client_type"] unsignedIntegerValue];
        self.platformType = [dict[@"service_client_type"] unsignedIntegerValue];
        self.senderID = [dict[@"user_id"] unsignedIntegerValue];
        self.senderName = dict[@"userName"];
        self.receiverID = [dict[@"receive_id"] unsignedIntegerValue];
        self.receiverName = dict[@"receiveUserName"];
        self.createTime = dict[@"create_time"];
        self.danStr = dict[@"dan"];
        
        if (self.status == ORDERSTAUTS_CANCELED)
        {
            self.displayStatus = ORDERDISPLAYSTATUS_CANCEL;
        }
        else
        {
            switch (self.payStatus)
            {
                case ORDERPAYSTAUTS_BACKPAY:
                    self.displayStatus = ORDERDISPLAYSTATUS_BACKMONEY;
                    break;
                case ORDERPAYSTAUTS_WAITPAY:
                    self.displayStatus = ORDERDISPLAYSTATUS_WAITPAY;
                    break;
                case ORDERPAYSTAUTS_FAILPAY:
                    self.displayStatus = ORDERDISPLAYSTATUS_FIALPAY;
                    break;
                case ORDERPAYSTAUTS_ALREADYPAY:
                {
                    switch (_status)
                    {
                        case ORDERSTAUTS_WAIT:
                            self.displayStatus = ORDERDISPLAYSTATUS_WIATRECV;
                            break;
                        case ORDERSTAUTS_DOING:
                            self.displayStatus = ORDERDISPLAYSTATUS_ONDOING;
                            break;
                        case ORDERSTAUTS_COMMENT:
                            self.displayStatus = ORDERDISPLAYSTATUS_WAITCOMMENT;
                            break;
                        case ORDERSTAUTS_COMPLETED:
                            self.displayStatus = ORDERDISPLAYSTATUS_COMPLETED;
                            break;
                            
                        default:
                            break;
                    }
                }
                    break;
                    
                default:
                    break;
            }
        }
    }
    return self;
}

@end
