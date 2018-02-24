//
//  CCRegisterManager.h
//  esportking
//
//  Created by CKQ on 2018/2/6.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCRegisterTypeDefine.h"

@protocol CCRegisterDelegate<NSObject>

- (void)onGetSMSCodeSuccess:(NSDictionary *)dict;
- (void)onGetSMSCodeFailed:(NSInteger)error errorMsg:(NSString *)msg;

- (void)onRegisterSuccess:(NSDictionary *)dict;
- (void)onRegisterFailed:(NSInteger)error errorMsg:(NSString *)msg;

@end

@interface CCRegisterManager : NSObject

- (instancetype)initWithType:(REGISTERTYPE)type delegate:(id<CCRegisterDelegate>)del;
- (void)getSMSCodeWithPhone:(NSString *)phoneNum;
- (void)startRegisterWithPhone:(NSString *)phoneNum password:(NSString *)pwd smsCode:(NSString *)code;

@end
