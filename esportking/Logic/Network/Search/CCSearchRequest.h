//
//  CCSearchRequest.h
//  esportking
//
//  Created by CKQ on 2018/2/18.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCBaseRequest.h"

@interface CCSearchRequest : CCBaseRequest

@property (assign, nonatomic) uint64_t gameID;
@property (strong, nonatomic) NSString *keywords;

@end
