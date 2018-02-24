//
//  CCGameInfoManager.h
//  esportking
//
//  Created by CKQ on 2018/2/14.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CCGameInfoServiceInstance  [CCGameInfoService shareInstance]

@interface CCGameInfoService : NSObject

+ (instancetype)shareInstance;

- (NSArray *)getGameArray;

@end
