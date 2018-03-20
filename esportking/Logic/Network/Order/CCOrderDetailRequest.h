//
//  CCOrderDetailRequest.h
//  esportking
//
//  Created by jaycechen on 2018/3/20.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCBaseRequest.h"
#import "CCOrderModel.h"

@interface CCOrderDetailRequest : CCBaseRequest

// req
@property (strong, nonatomic) NSString *orderID;

// resp
@property (strong, nonatomic) CCOrderModel *orderModel;

@end
