//
//  CCUploadImgRequest.m
//  esportking
//
//  Created by jaycechen on 2018/3/2.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCUploadImgRequest.h"
#import <AFNetwork.h>

@interface CCUploadImgRequest()

@property (weak, nonatomic) id<CCUploadImgDelegate> delegate;

@end

@implementation CCUploadImgRequest

- (void)startUploadWithUrl:(NSString *)uploadUrl andDelegate:(id<CCUploadImgDelegate>)del
{
    _delegate = del;
    
    CCWeakSelf(weakSelf);
    [[AFNetwork shareManager] POST:uploadUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *headData = UIImageJPEGRepresentation(self.uploadImage, 1);
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"image_%@.jpg", str];
        
        [formData appendPartWithFileData:headData
                                    name:weakSelf.uploadKey
                                fileName:fileName
                                mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"[Upload] progress = %.2f", 1.f*uploadProgress.completedUnitCount/uploadProgress.totalUnitCount);
        if ([weakSelf.delegate respondsToSelector:@selector(onUploadProgress:)])
        {
            [weakSelf.delegate onUploadProgress:uploadProgress];
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"[Upload] Success!%@", responseObject);
        NSDictionary *resp = responseObject;
        if ([resp[@"msgCode"] integerValue] == 0)
        {
            [weakSelf.delegate onUploadSuccess:responseObject];
        }
        else
        {
            [weakSelf.delegate onUploadFailed:[resp[@"msgCode"] integerValue] errMsg:resp[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"[Upload] Failed!%@", error.localizedDescription);
        [weakSelf.delegate onUploadFailed:error.code errMsg:error.localizedDescription];
    }];
}

@end
