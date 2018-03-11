//
//  CCScoreModel.h
//  esportking
//
//  Created by jaycechen on 2018/3/9.
//  Copyright © 2018年 wan353. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    SYSTEM_iOS = 1,
    SYSTEM_Android,
} SYSTEM;

typedef enum : NSUInteger {
    PLATFORM_QQ = 1,
    PLATFORM_WX,
} PLATFORM;

@interface CCScoreModel : NSObject

@property (assign, nonatomic) BOOL needReCaculate;

@property (assign, nonatomic) SCORESTYLE style;
@property (assign, nonatomic) SYSTEM system;
@property (assign, nonatomic) PLATFORM platform;

// 上分专车
@property (assign, nonatomic) uint32_t startLevel;
@property (assign, nonatomic) uint32_t endLevel;

// 娱乐快车
@property (assign, nonatomic) LEVEL level;
@property (assign, nonatomic) uint32_t count;

- (BOOL)checkInfoCompleted;
- (void)calCulateMoney:(void(^)(BOOL, uint32_t))calculateBlock;

+ (NSString *)getSytleStr:(SCORESTYLE)style;
+ (NSString *)getSystemStr:(SYSTEM)system;
+ (NSString *)getPlatformStr:(PLATFORM)platform;

+ (NSString *)getDetailLevelStr:(uint32_t)level;

+ (NSString *)getLevelStr:(uint32_t)level;
+ (NSString *)getCountStr:(uint32_t)count;

@end
