//
//  CCOrderSessionViewController.h
//  esportking
//
//  Created by jaycechen on 2018/3/21.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCBaseViewController.h"
#import <NIMKit.h>
#import "CCUserModel.h"
#import "CCOrderModel.h"

@interface CCOrderSessionViewController : CCBaseViewController

- (instancetype)initWithSession:(NIMSession *)session orderModel:(CCOrderModel *)model receiver:(CCUserModel *)user;

@end
