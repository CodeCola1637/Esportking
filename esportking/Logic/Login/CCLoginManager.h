//
//  CCLoginManager.h
//  esportking
//
//  Created by CKQ on 2018/2/4.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CCLoginDelegate <NSObject>

- (void)onLoginSuccess:(NSDictionary *)dict;
- (void)onLoginFail:(NSInteger)code errorMsg:(NSString *)msg;

@end

@interface CCLoginManager : NSObject

- (instancetype)initWithDel:(id<CCLoginDelegate>)del;

- (void)loginWithMobile:(NSString *)mobile password:(NSString *)password;
- (void)loginWithQQToken:(NSString *)token openID:(NSString *)openID;
- (void)loginWithWXToken:(NSString *)token openID:(NSString *)openID;
- (void)loginWithInfo:(NSDictionary *)loginInfo;
@end
