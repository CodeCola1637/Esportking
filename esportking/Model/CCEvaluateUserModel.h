//
//  CCEvaluateUserModel.h
//  esportking
//
//  Created by jaycechen on 2018/3/9.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCUserModel.h"

@interface CCEvaluateUserModel : CCUserModel

@property (assign, nonatomic) uint64_t orderCount;
@property (assign, nonatomic) uint64_t starCount;

- (instancetype)initWithUserModel:(CCUserModel *)userModel;

@end
