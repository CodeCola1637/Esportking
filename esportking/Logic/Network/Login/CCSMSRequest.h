//
//  CCSMSRequest.h
//  esportking
//
//  Created by CKQ on 2018/2/6.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCBaseRequest.h"
#import "CCRegisterTypeDefine.h"

@interface CCSMSRequest : CCBaseRequest

@property (strong, nonatomic) NSString      *phoneNum;
@property (assign, nonatomic) REGISTERTYPE  type;

@end
