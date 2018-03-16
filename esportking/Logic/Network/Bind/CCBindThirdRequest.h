//
//  CCBindThirdRequest.h
//  esportking
//
//  Created by jaycechen on 2018/3/16.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCBaseRequest.h"

@interface CCBindThirdRequest : CCBaseRequest

@property (assign, nonatomic) PLATFORM platform;
@property (strong, nonatomic) NSString *token;
@property (strong, nonatomic) NSString *openID;

@end
