//
//  CCBaseRequest.h
//  esportking
//
//  Created by CKQ on 2018/2/4.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCNetworkDefine.h"

@protocol CCRequestDelegate <NSObject>

- (void)onRequestSuccess:(NSDictionary *)dict sender:(id)sender;
- (void)onRequestFailed:(NSInteger)errorCode errorMsg:(NSString *)msg sender:(id)sender;

@end

@interface CCBaseRequest : NSObject

- (void)startPostRequestWithDelegate:(id<CCRequestDelegate>)delegate;
- (void)startGetRequestWithDelegate:(id<CCRequestDelegate>)delegate;

// 子类继承
- (NSString *)subAddress;
- (NSDictionary *)requestParam;
- (void)decodeData:(NSDictionary *)resp;

@end
