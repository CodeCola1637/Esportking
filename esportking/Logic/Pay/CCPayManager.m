//
//  CCPayManager.m
//  esportking
//
//  Created by jaycechen on 2018/5/1.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCPayManager.h"
#import "CCFetchOrderStrRequest.h"
#import "NSString+MD5.h"

@interface CCPayManager()<CCRequestDelegate>

@property (nonatomic, strong) CCFetchOrderStrRequest *request;

@property (nonatomic, copy) void(^PaySuccess)();
@property (nonatomic, copy) void(^PayError)(NSString *err_msg);

@end

@implementation CCPayManager

+ (instancetype)shareInstance
{
    static CCPayManager *shareManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [CCPayManager new];
    });
    return shareManager;
}

- (void)wxPayWithPayOrderID:(NSString *)orderID
                   moneyStr:(NSString *)moneyStr
                    success:(void (^)(void))successBlock
                    failure:(void (^)(NSString *))failBlock
{
    
    if(![WXApi isWXAppInstalled])
    {
        failBlock(@"需要安装微信客户端");
        return ;
    }
    
    self.PaySuccess = successBlock;
    self.PayError = failBlock;
    
    CCFetchOrderStrRequest *req = [CCFetchOrderStrRequest new];
    req.amount = moneyStr;
    req.orderID = orderID;
    req.payType = 2;
    req.typeWay = 2;
    self.request = req;
    [self.request startPostRequestWithDelegate:self];
}

- (void)aliPayWithPayOrderID:(NSString *)orderID
                    moneyStr:(NSString *)moneyStr
                     success:(void (^)(void))successBlock
                     failure:(void (^)(NSString *))failBlock
{
    self.PaySuccess = successBlock;
    self.PayError = failBlock;
    
    CCFetchOrderStrRequest *req = [CCFetchOrderStrRequest new];
    req.amount = moneyStr;
    req.orderID = orderID;
    req.payType = 2;
    req.typeWay = 1;
    self.request = req;
    [self.request startPostRequestWithDelegate:self];
}

- (BOOL) handleOpenURL:(NSURL *) url
{
    if ([url.host isEqualToString:@"safepay"])
    {
        CCWeakSelf(weakSelf);
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            if ([resultDic[@"resultStatus"] isEqual:@"9000"])
            {
                weakSelf.PaySuccess();
            }
            else
            {
                weakSelf.PayError(@"支付失败");
            }
        }];
        return YES;
    }
    return [WXApi handleOpenURL:url delegate:self];
}

#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp
{
    if ([resp isKindOfClass:[PayResp class]])
    {
        PayResp*response=(PayResp*)resp;  // 微信终端返回给第三方的关于支付结果的结构体
        
        switch (response.errCode) {
            case WXSuccess:
                self.PaySuccess();
                break;
                
            case WXErrCodeUserCancel:   //用户点击取消并返回
                self.PayError(@"支付取消");
                break;
                
            default:        //剩余都是支付失败
                self.PayError(@"支付失败");
                break;
        }
    }
}

#pragma mark -
- (void)onRequestSuccess:(NSDictionary *)dict sender:(id)sender
{
    if (self.request != sender)
    {
        return;
    }
    
    if (self.request.typeWay == 1)
    {
        CCWeakSelf(weakSelf);
        NSString *str = dict[@"data"];
        [[AlipaySDK defaultService] payOrder:str fromScheme:@"esportking.pay.zfb" callback:^(NSDictionary *resultDic) {
            if ([resultDic[@"resultStatus"] isEqual:@"9000"])
            {
                weakSelf.PaySuccess();
            }
            else
            {
                weakSelf.PayError(@"支付失败");
            }
        }];
    }
    else if (self.request.typeWay == 2)
    {
        //发起微信支付
        PayReq* req   = [[PayReq alloc] init];
        req.partnerId = @"1494148072";
        req.prepayId  = dict[@"data"];
        req.nonceStr  = [NSString stringWithFormat:@"%d", arc4random()];
        req.timeStamp = (int)[[NSDate date] timeIntervalSince1970];
        req.package   = @"Sign=WXPay";
        
        NSString *totalStr = [NSString stringWithFormat:@"noncestr=%@&package=%@&partnerid=%@&prepayid=%@&timestamp=%d&key=%@", req.nonceStr, req.package, req.partnerId, req.prepayId, req.timeStamp, @"djw336d0df1342312922d119c7285djw"];
        req.sign      = [totalStr md5Str];
        BOOL success = [WXApi sendReq:req];
        NSLog(@"sendReq = %i", success);
    }
    self.request = nil;
}

- (void)onRequestFailed:(NSInteger)errorCode errorMsg:(NSString *)msg sender:(id)sender
{
    if (self.request != sender)
    {
        return;
    }
    self.PayError(@"支付失败");
}

@end
