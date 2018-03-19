//
//  CCFetchTagRequest.h
//  esportking
//
//  Created by jaycechen on 2018/3/19.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCBaseRequest.h"
#import "CCTagModel.h"

@interface CCFetchTagRequest : CCBaseRequest

// req
@property (assign, nonatomic) GAMEID gameID;

// resp
@property (strong, nonatomic) NSArray<CCTagModel *> *tagList;

@end
