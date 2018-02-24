//
//  CCLoginRequest.h
//  esportking
//
//  Created by CKQ on 2018/2/4.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCBaseRequest.h"

typedef enum : NSUInteger {
    PLATFORM_PHONE = 0,
    PLATFORM_QQ,
    PLATFORM_WX,
} PLATFORM;

@interface CCLoginRequest : CCBaseRequest

@property (strong, nonatomic) NSString *mobile;
@property (strong, nonatomic) NSString *password;

@property (strong, nonatomic) NSString *token;
@property (strong, nonatomic) NSString *openID;
@property (assign, nonatomic) PLATFORM platform;

@end
