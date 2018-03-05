//
//  CCModifyUserInfoRequest.h
//  esportking
//
//  Created by CKQ on 2018/2/8.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCBaseRequest.h"
#import "CCUserModel.h"

@interface CCModifyUserInfoRequest : CCBaseRequest

@property (strong, nonatomic) NSString  *name;
@property (strong, nonatomic) NSString  *birth;
@property (assign, nonatomic) GENDER    gender;

@end
