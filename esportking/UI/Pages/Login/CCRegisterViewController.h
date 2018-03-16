//
//  CCRegisterViewController.h
//  esportking
//
//  Created by CKQ on 2018/2/4.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCBaseViewController.h"
#import "CCRegisterTypeDefine.h"

@protocol CCRegisterViewControllerDelegate <NSObject>

@optional
- (void)onRegisterAndBindPhoneSuccess:(NSString *)phoneNum;

@end

@interface CCRegisterViewController : CCBaseViewController

- (instancetype)initWithType:(REGISTERTYPE)type del:(id<CCRegisterViewControllerDelegate>)del;

@end
