//
//  CCFetchOrderStrRequest.h
//  esportking
//
//  Created by CKQ on 2018/4/22.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCBaseRequest.h"

@interface CCFetchOrderStrRequest : CCBaseRequest

@property NSString *orderID;
@property NSString *amount;
@property int payType;
@property int typeWay;

@end
