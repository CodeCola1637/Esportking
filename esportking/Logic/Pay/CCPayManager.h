//
//  CCPayManager.h
//  esportking
//
//  Created by jaycechen on 2018/5/1.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WXApi.h>
#import <AlipaySDK/AlipaySDK.h>

typedef enum : NSUInteger {
    PAY_SUCCESS = 0,
    PAY_FAIL,
    PAY_CANCEL,
} PAYSTATE;

@interface CCPayManager : NSObject<WXApiDelegate>

+ (instancetype)shareInstance;

/**
 *  发起微信支付请求
 *
 *  @param orderID      订单号
 *  @param moneyStr     金额
 *  @param successBlock 成功
 *  @param failBlock    失败
 */
- (void)wxPayWithPayOrderID:(NSString *)orderID
                   moneyStr:(NSString *)moneyStr
                    success:(void (^)(void))successBlock
                    failure:(void (^)(NSString *))failBlock;

/**
 *  发起支付宝支付请求
 *
 *  @param orderID      订单号
 *  @param moneyStr     金额
 *  @param successBlock 成功
 *  @param failBlock    失败
 */
- (void)aliPayWithPayOrderID:(NSString *)orderID
                    moneyStr:(NSString *)moneyStr
                     success:(void (^)(void))successBlock
                     failure:(void (^)(NSString *))failBlock;

/**
 *  回调入口
 *
 *  @param url <#url description#>
 *
 *  @return <#return value description#>
 */
- (BOOL) handleOpenURL:(NSURL *) url;

@end
