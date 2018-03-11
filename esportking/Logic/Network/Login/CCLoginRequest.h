//
//  CCLoginRequest.h
//  esportking
//
//  Created by CKQ on 2018/2/4.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCBaseRequest.h"

typedef enum : NSUInteger {
    LOGINTYPE_PHONE = 0,
    LOGINTYPE_QQ,
    LOGINTYPE_WX,
} LOGINTYPE;

@interface CCLoginRequest : CCBaseRequest

@property (strong, nonatomic) NSString *mobile;
@property (strong, nonatomic) NSString *password;

@property (strong, nonatomic) NSString *token;
@property (strong, nonatomic) NSString *openID;
@property (assign, nonatomic) LOGINTYPE platform;

@end
