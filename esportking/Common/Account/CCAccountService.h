//
//  CCAccountService.h
//  esportking
//
//  Created by CKQ on 2018/2/9.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CCAccountServiceInstance [CCAccountService shareInstance]

@interface CCAccountService : NSObject

+ (instancetype)shareInstance;

@property (assign, nonatomic) uint64_t userID;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *gender;
@property (strong, nonatomic) NSString *star;
@property (assign, nonatomic) uint32_t age;
@property (strong, nonatomic) NSString *headUrl;

@property (strong, nonatomic) NSString *mobile;
@property (strong, nonatomic) NSString *imToken;
@property (strong, nonatomic) NSString *token;

- (void)setUserInfo:(NSDictionary *)dict;

- (void)saveLoginDict:(NSDictionary *)dict;
- (NSDictionary *)getLoginDict;

@end
