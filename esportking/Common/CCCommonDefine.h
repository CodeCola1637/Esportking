//
//  CCCommonDefine.h
//  esportking
//
//  Created by CKQ on 2018/2/4.
//  Copyright © 2018年 wan353. All rights reserved.
//

#pragma mark - Notification
#define CCLoginNotification         @"cc_login"
#define CCInfoChangeNotification    @"cc_user_info_change"

#pragma mark - Utils
#define CCWeakSelf(weakSelf) __weak typeof(self) weakSelf = self
#define CCNoNilStr(str) (str!=nil?str:@"")
#define CCStrToUrl(str) (str!=nil?[NSURL URLWithString:str]:nil)
#define CCIsNotNullObj(obj) (obj!=nil && obj!=[NSNull null])

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
    ORDERSOURCE_SEND = 1,
    ORDERSOURCE_RECV,
} ORDERSOURCE;

typedef enum : NSUInteger {
    ORDERDISPLAYSTATUS_CANCEL = 1,
    ORDERDISPLAYSTATUS_BACKMONEY,
    ORDERDISPLAYSTATUS_WAITPAY,
    ORDERDISPLAYSTATUS_FIALPAY,
    ORDERDISPLAYSTATUS_WIATRECV,
    ORDERDISPLAYSTATUS_ONDOING,
    ORDERDISPLAYSTATUS_WAITCOMMENT,
    ORDERDISPLAYSTATUS_COMPLETED,
} ORDERDISPLAYSTATUS;

typedef enum : NSUInteger {
    MONEYTYPE_ALL,
    MONEYTYPE_OUT,
    MONEYTYPE_IN,
} MONEYTYPE;

typedef enum : NSUInteger {
    SCORESTYLE_SCORE = 1,
    SCORESTYLE_GAME,
} SCORESTYLE;

typedef enum : NSUInteger {
    LEVEL_QINGTONG = 1,
    LEVEL_BAIYIN,
    LEVEL_HUANGJIN,
    LEVEL_BOJIN,
    LEVEL_ZUANSHI,
    LEVEL_XINGYAO,
    LEVEL_WANGZHE,
} LEVEL;

typedef enum : NSUInteger {
    PLATFORM_QQ = 1,
    PLATFORM_WX,
} PLATFORM;
