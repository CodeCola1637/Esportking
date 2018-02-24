//
//  CCUserModel.h
//  esportking
//
//  Created by CKQ on 2018/2/9.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCUserModel : NSObject

@property (assign, nonatomic) uint64_t  userID;
@property (strong, nonatomic) NSString  *name;
@property (strong, nonatomic) NSString  *star;
@property (assign, nonatomic) GENDER    gender;
@property (assign, nonatomic) uint32_t  age;
@property (strong, nonatomic) NSString  *headUrl;

- (void)setUserInfo:(NSDictionary *)info;

@end
