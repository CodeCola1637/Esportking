//
//  CCScoreWaitViewController.h
//  esportking
//
//  Created by jaycechen on 2018/3/8.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCBaseViewController.h"

@interface CCScoreWaitViewController : CCBaseViewController

- (instancetype)initWithService:(NSString *)service system:(NSString *)system dan:(NSString *)dan count:(uint32_t)count money:(uint32_t)money;

@end
