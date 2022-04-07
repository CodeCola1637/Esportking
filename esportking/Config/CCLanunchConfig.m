//
//  CCLanunchConfig.m
//  esportking
//
//  Created by CKQ on 2018/2/3.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCLanunchConfig.h"

#import "CCAccountService.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <WXApi.h>
#import <WeiboSDK.h>
#import <AFNetwork.h>
#import <NIMSDK/NIMSDK.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

#define kNetEaseIMKey   @"68aff658e680c288555f2b42c1286b99"
#define kGaoDeMapKey    @"849552e95b2953b953747cb113db4dbb"

@implementation CCLanunchConfig

+ (void)configAll
{
    [self configShareSDK];
    [self configAFNetworkManager];
    [self configMap];
}

+ (void)configAfterLogin
{
    [self configAFNetworkToken];
    [self configIMSDK];
}

+ (void)configShareSDK
{
    /**初始化ShareSDK应用
     
     @param activePlatforms
     使用的分享平台集合
     @param importHandler (onImport)
     导入回调处理，当某个平台的功能需要依赖原平台提供的SDK支持时，需要在此方法中对原平台SDK进行导入操作
     @param configurationHandler (onConfiguration)
     配置回调处理，在此方法中根据设置的platformType来填充应用配置信息
     */
    [ShareSDK registerActivePlatforms:@[
                                        @(SSDKPlatformTypeSinaWeibo),
                                        @(SSDKPlatformTypeWechat),
                                        @(SSDKPlatformTypeQQ),
                                        ]
                             onImport:^(SSDKPlatformType platformType)
    {
         switch (platformType)
        {
                case SSDKPlatformTypeWechat:
            {
                [ShareSDKConnector connectWeChat:[WXApi class]];
                break;
            }
                case SSDKPlatformTypeQQ:
            {
                [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                break;
            }
                case SSDKPlatformTypeSinaWeibo:
            {
                [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                break;
            }
            default:
                break;
        }
    }
                      onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
    {
         
        switch (platformType)
        {
                case SSDKPlatformTypeSinaWeibo:
            {
                //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                [appInfo SSDKSetupSinaWeiboByAppKey:@""
                                          appSecret:@""
                                        redirectUri:@"http://www.sharesdk.cn"
                                           authType:SSDKAuthTypeBoth];
                break;
            }
                case SSDKPlatformTypeWechat:
            {
                [appInfo SSDKSetupWeChatByAppId:@"wx37419cecfd382568"
                                      appSecret:@""];
                break;
            }
                case SSDKPlatformTypeQQ:
            {
                [appInfo SSDKSetupQQByAppId:@"1106645277"
                                     appKey:@""
                                   authType:SSDKAuthTypeBoth];
                break;
            }
            default:
                break;
        }
    }];
}

+ (void)configAFNetworkManager
{
    [AFNetwork shareManager].requestSerializer = [AFJSONRequestSerializer serializer];
    [AFNetwork shareManager].responseSerializer = [AFJSONResponseSerializer serializer];

    [AFNetwork shareManager].requestSerializer.timeoutInterval = 10.f;
    [[AFNetwork shareManager].requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [[AFNetwork shareManager].requestSerializer setValue:@"2" forHTTPHeaderField:@"client_type"];
    [[AFNetwork shareManager].requestSerializer setValue:[UIDevice currentDevice].systemVersion forHTTPHeaderField:@"os_version"];
    [[AFNetwork shareManager].requestSerializer setValue:[UIDevice currentDevice].model forHTTPHeaderField:@"os_model"];
    [[AFNetwork shareManager].requestSerializer setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forHTTPHeaderField:@"version"];
    [[AFNetwork shareManager].requestSerializer setValue:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forHTTPHeaderField:@"device_id"];
}

+ (void)configMap
{
    [[AMapServices sharedServices] setApiKey:kGaoDeMapKey];
}

+ (void)configIMSDK
{
    NIMSDKOption *option = [NIMSDKOption optionWithAppKey:kNetEaseIMKey];
    [[NIMSDK sharedSDK] registerWithOption:option];
    [[[NIMSDK sharedSDK] loginManager] login:[NSString stringWithFormat:@"test_%llu", CCAccountServiceInstance.userID] token:CCAccountServiceInstance.imToken completion:^(NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"[IM Error] %@", error.localizedDescription);
        }
    }];
}

+ (void)configAFNetworkToken
{
     [[AFNetwork shareManager].requestSerializer setValue:CCAccountServiceInstance.token forHTTPHeaderField:@"token"];
}

@end
