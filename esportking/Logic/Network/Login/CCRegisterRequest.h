//
//  CCRegisterRequest.h
//  esportking
//
//  Created by CKQ on 2018/2/6.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCBaseRequest.h"
#import "CCRegisterTypeDefine.h"

@interface CCRegisterRequest : CCBaseRequest

@property (strong, nonatomic) NSString      *phoneNum;
@property (strong, nonatomic) NSString      *password;
@property (assign, nonatomic) NSString      *smsCode;
@property (assign, nonatomic) REGISTERTYPE  type;

@end
