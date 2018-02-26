//
//  CCTagModel.h
//  esportking
//
//  Created by CKQ on 2018/2/25.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCTagModel : NSObject

@property (assign, nonatomic) uint64_t tagID;
@property (assign, nonatomic) uint64_t gameID;
@property (assign, nonatomic) uint64_t agreeCount;
@property (strong, nonatomic) NSString *tagName;

- (instancetype)initWithTagDict:(NSDictionary *)dict;

@end
