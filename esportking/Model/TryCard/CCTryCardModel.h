//
//  CCTryCardModel.h
//  esportking
//
//  Created by jaycechen on 2018/3/11.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    TRYCARDSTATUS_UNUSE = 0,
    TRYCARDSTATUS_USED,
} TRYCARDSTATUS;

@interface CCTryCardModel : NSObject

@property (strong, nonatomic) NSString *cardID;
@property (assign, nonatomic) TRYCARDSTATUS status;
@property (assign, nonatomic) uint32_t discount;
@property (strong, nonatomic) NSString *infoStr;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
