//
//  CCModifyUserInfoViewController.h
//  esportking
//
//  Created by CKQ on 2018/2/6.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCBaseViewController.h"

typedef enum : NSUInteger {
    MODIFYTYPE_REGISTER,
    MODIFYTYPE_MODIFY,
} MODIFYTYPE;

@interface CCModifyUserInfoViewController : CCBaseViewController

- (instancetype)initWithType:(MODIFYTYPE)type;

@end
