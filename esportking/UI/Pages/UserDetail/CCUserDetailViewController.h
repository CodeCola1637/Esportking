//
//  CCUserDetailViewController.h
//  esportking
//
//  Created by CKQ on 2018/2/25.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCBaseViewController.h"

@interface CCUserDetailViewController : CCBaseViewController

- (instancetype)initWithUserID:(uint64_t)userID gameID:(uint64_t)gameID userGameID:(uint64_t)userGameID;

@end
