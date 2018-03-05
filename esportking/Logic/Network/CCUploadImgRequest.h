//
//  CCUploadImgRequest.h
//  esportking
//
//  Created by jaycechen on 2018/3/2.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CCUploadImgDelegate <NSObject>

@required
- (void)onUploadSuccess:(NSDictionary *)dict;
- (void)onUploadFailed:(NSInteger)errCode errMsg:(NSString *)msg;

@optional
- (void)onUploadProgress:(NSProgress *)progress;

@end

@interface CCUploadImgRequest : NSObject

@property (strong, nonatomic) NSString *uploadKey;
@property (strong, nonatomic) UIImage *uploadImage;

- (void)startUploadWithUrl:(NSString *)uploadUrl andDelegate:(id<CCUploadImgDelegate>)del;

@end
