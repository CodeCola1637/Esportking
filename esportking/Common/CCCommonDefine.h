//
//  CCCommonDefine.h
//  esportking
//
//  Created by CKQ on 2018/2/4.
//  Copyright © 2018年 wan353. All rights reserved.
//

#pragma mark - Notification
#define CCLoginNotification @"cc_login"

#pragma mark - Utils
#define CCWeakSelf(weakSelf) __weak typeof(self) weakSelf = self
#define CCNoNilStr(str) (str!=nil?str:@"")
#define CCStrToUrl(str) (str!=nil?[NSURL URLWithString:str]:nil)

typedef enum : NSUInteger {
    GAMEID_WANGZHE = 1,
} GAMEID;

typedef enum : NSUInteger {
    GENDER_BOY = 1,
    GENDER_GIRL,
    GENDER_COUNT,
} GENDER;

typedef enum : NSUInteger {
    CLIENTTYPE_UNKNOWN = 0,
    CLIENTTYPE_ANDROID,
    CLIENTTYPE_IOS,
} CLIENTTYPE;

typedef enum : NSUInteger {
    ORDERTYPE_BYROUND = 1,
    ORDERTYPE_BYHOUR,
    ORDERTYPE_BOTH,
} ORDERTYPE;

typedef enum : NSUInteger {
    ORDERTYPE_SEND,
    ORDERTYPE_RECV,
} ORDERTYPE;

typedef enum : NSUInteger {
    MONEYTYPE_ALL,
    MONEYTYPE_OUT,
    MONEYTYPE_IN,
} MONEYTYPE;
