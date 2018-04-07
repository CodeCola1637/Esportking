//
//  CCComeInModel.m
//  esportking
//
//  Created by CKQ on 2018/4/5.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import "CCComeInModel.h"

@implementation CCComeInModel

- (BOOL)checkStep1InfoComplete
{
    return self.maxDan && self.skilled && self.honour && self.platformType!=0 && self.clientType!=0 && self.gender!=0 && self.danImg;
}

- (BOOL)checkStep2InfoComplete
{
    return [self checkStep1InfoComplete] && self.contact && self.identifyImg;
}

@end
