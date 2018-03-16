//
//  CCGetMyBindRequest.h
//  esportking
//
//  Created by jaycechen on 2018/3/16.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCBaseRequest.h"

@interface CCGetMyBindRequest : CCBaseRequest

@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) BOOL wxBinded;
@property (strong, nonatomic) BOOL qqBinded;

@end
