//
//  CCPayForOrderRequest.h
//  esportking
//
//  Created by jaycechen on 2018/3/20.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCBaseRequest.h"

@interface CCPayForOrderRequest : CCBaseRequest

@property (strong, nonatomic) NSString *orderID;
@property (assign, nonatomic) CGFloat money;
@property (strong, nonatomic) NSString *payPwd;

@end
