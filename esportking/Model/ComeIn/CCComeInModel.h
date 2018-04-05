//
//  CCComeInModel.h
//  esportking
//
//  Created by CKQ on 2018/4/5.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCComeInModel : NSObject

@property (strong, nonatomic) NSString *maxDan;
@property (assign, nonatomic) PLATFORM platformType;
@property (assign, nonatomic) CLIENTTYPE clientType;
@property (strong, nonatomic) NSString *skilled;
@property (strong, nonatomic) NSString *position;
@property (strong, nonatomic) NSString *honour;
@property (assign, nonatomic) GENDER gender;

@property (strong, nonatomic) UIImage *danImg;

- (BOOL)checkInfoComplete;

@end
