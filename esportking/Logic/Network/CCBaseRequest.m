//
//  CCBaseRequest.m
//  esportking
//
//  Created by CKQ on 2018/2/4.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCBaseRequest.h"
#import <AFNetwork.h>

@implementation CCBaseRequest
{
    __weak id<CCRequestDelegate> _delegate;
}

- (void)startPostRequestWithDelegate:(id<CCRequestDelegate>)delegate
{
    _delegate = delegate;
    [self startRequestWithMethod:POST];
}

- (void)startGetRequestWithDelegate:(id<CCRequestDelegate>)delegate
{
    _delegate = delegate;
    [self startRequestWithMethod:GET];
}

- (NSString *)subAddress
{
    return @"";
}

- (NSDictionary *)requestParam
{
    return nil;
}

- (void)onResponse:(NSDictionary *)resp
{
    if ([resp[@"msgCode"] integerValue] == 0)
    {
        if (_delegate && [_delegate respondsToSelector:@selector(onRequestSuccess:sender:)])
        {
            [_delegate onRequestSuccess:resp sender:self];
        }
    }
    else
    {
        if (_delegate && [_delegate respondsToSelector:@selector(onRequestFailed:errorMsg:sender:)])
        {
            [_delegate onRequestFailed:[resp[@"msgCode"] integerValue] errorMsg:resp[@"msg"] sender:self];
        }
    }
}

#pragma mark - Private
- (void)startRequestWithMethod:(HTTPMethod)method
{
    NSString *reqUrl = [NSString stringWithFormat:@"%@%@", RootAddress, [self subAddress]];
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithDictionary:[self requestParam]];
    
    CCWeakSelf(weakSelf);
    [[AFNetwork shareManager] requestWithMethod:method url:reqUrl params:param success:^(NSURLSessionDataTask *task, NSDictionary *dict) {
        [weakSelf onResponse:dict];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [weakSelf onResponse:@{@"msgCode":@(Error_UnKnown), @"msg":@"Unknown Error！"}];
    }];
}

@end
