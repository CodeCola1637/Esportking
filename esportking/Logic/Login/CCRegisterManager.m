//
//  CCRegisterManager.m
//  esportking
//
//  Created by CKQ on 2018/2/6.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCRegisterManager.h"
#import "CCSMSRequest.h"
#import "CCRegisterRequest.h"

@interface CCRegisterManager()<CCRequestDelegate>

@property (weak  , nonatomic) id<CCRegisterDelegate> del;
@property (assign, nonatomic) REGISTERTYPE  type;
@property (strong, nonatomic) CCBaseRequest *request;

@end

@implementation CCRegisterManager

- (instancetype)initWithType:(REGISTERTYPE)type delegate:(id<CCRegisterDelegate>)del
{
    if (self = [super init])
    {
        _type = type;
        _del = del;
    }
    return self;
}

- (void)getSMSCodeWithPhone:(NSString *)phoneNum
{
    if (_request)
    {
        return;
    }
    CCSMSRequest *req = [CCSMSRequest new];
    req.phoneNum = phoneNum;
    req.type = self.type;
    _request = req;
    [req startPostRequestWithDelegate:self];
}

- (void)startRegisterWithPhone:(NSString *)phoneNum password:(NSString *)pwd smsCode:(NSString *)code
{
    if (_request)
    {
        return;
    }
    CCRegisterRequest *req = [CCRegisterRequest new];
    req.phoneNum = phoneNum;
    req.password = pwd;
    req.smsCode = code;
    req.type = self.type;
    _request = req;
    [req startPostRequestWithDelegate:self];
}

#pragma mark - CCRequestDelegate
- (void)onRequestSuccess:(NSDictionary *)dict sender:(id)sender
{
    if (sender != _request)
    {
        return;
    }
    _request = nil;
    if ([sender isKindOfClass:[CCSMSRequest class]])
    {
        [_del onGetSMSCodeSuccess:dict];
    }
    else if ([sender isKindOfClass:[CCRegisterRequest class]])
    {
        [_del onRegisterSuccess:dict];
    }
}

- (void)onRequestFailed:(NSInteger)errorCode errorMsg:(NSString *)msg sender:(id)sender
{
    if (sender != _request)
    {
        return;
    }
    _request = nil;
    if ([sender isKindOfClass:[CCSMSRequest class]])
    {
        [_del onGetSMSCodeFailed:errorCode errorMsg:msg];
    }
    else if ([sender isKindOfClass:[CCRegisterRequest class]])
    {
        [_del onRegisterFailed:errorCode errorMsg:msg];
    }
}

@end
