//
//  CCCancelOrderRequest.h
//  esportking
//
//  Created by jaycechen on 2018/3/15.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCBaseRequest.h"

@interface CCCancelOrderRequest : CCBaseRequest

@property (strong, nonatomic) NSString *orderID;

@end
